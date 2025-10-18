from fastapi import FastAPI
from sqlalchemy import create_engine, Column, Integer, String, Boolean, ForeignKey, BigInteger
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship

app = FastAPI()
Base = declarative_base()

# Modelos
class Menu(Base):
    __tablename__ = 'menus'
    id = Column(Integer, primary_key=True, autoincrement=True)
    text = Column(String(255), nullable=False)
    iconcls = Column(String(255))
    viewtype = Column(String(255), nullable=False)
    leaf = Column(Boolean, nullable=False)

class MenuItem(Base):
    __tablename__ = 'menu_items'
    id = Column(Integer, primary_key=True, autoincrement=True)
    menu_id = Column(Integer, ForeignKey('menus.id'), nullable=False)
    text = Column(String(255), nullable=False)
    iconCls = Column(String(255))
    viewType = Column(String(255), nullable=False)
    leaf = Column(Boolean, nullable=False)
    menu = relationship('Menu')

class SubMenu(Base):
    __tablename__ = 'sub_menus'
    id = Column(Integer, primary_key=True, autoincrement=True)
    menu_item_id = Column(Integer, ForeignKey('menu_items.id'), nullable=False)
    text = Column(String(255), nullable=False)
    iconCls = Column(String(255))
    viewType = Column(String(255), nullable=False)
    leaf = Column(Boolean, nullable=False)
    menu_item = relationship('MenuItem')

class Usuario(Base):
    __tablename__ = 'usuarios'
    id = Column(BigInteger, primary_key=True, autoincrement=True)
    nombre = Column(String(255))
    email = Column(String(255))


"""
Configura las credenciales por defecto para MySQL:
    usuario: root
    contraseña: (sin contraseña)
    host: localhost
    puerto: 3306
    base de datos: sisca
"""
DATABASE_URL = "mysql+mysqlconnector://root@localhost:3306/sisca"
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base.metadata.create_all(bind=engine)

# Dependencia para obtener sesión
from fastapi import Depends

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Endpoints ejemplo
@app.get("/menus")
def get_menus(db=Depends(get_db)):
    return db.query(Menu).all()

@app.get("/menu_items")
def get_menu_items(db=Depends(get_db)):
    return db.query(MenuItem).all()

@app.get("/sub_menus")
def get_sub_menus(db=Depends(get_db)):
    return db.query(SubMenu).all()

@app.get("/usuarios")
def get_usuarios(db=Depends(get_db)):
    return db.query(Usuario).all()


# Endpoints CRUD para usuarios
from pydantic import BaseModel

class UsuarioCreate(BaseModel):
    nombre: str
    email: str

class UsuarioUpdate(BaseModel):
    nombre: str | None = None
    email: str | None = None

@app.post("/usuarios")
def crear_usuario(usuario: UsuarioCreate, db=Depends(get_db)):
    nuevo_usuario = Usuario(nombre=usuario.nombre, email=usuario.email)
    db.add(nuevo_usuario)
    db.commit()
    db.refresh(nuevo_usuario)
    return nuevo_usuario

@app.put("/usuarios/{usuario_id}")
def actualizar_usuario(usuario_id: int, usuario: UsuarioUpdate, db=Depends(get_db)):
    usuario_db = db.query(Usuario).filter(Usuario.id == usuario_id).first()
    if not usuario_db:
        return {"error": "Usuario no encontrado"}
    if usuario.nombre is not None:
        usuario_db.nombre = usuario.nombre
    if usuario.email is not None:
        usuario_db.email = usuario.email
    db.commit()
    db.refresh(usuario_db)
    return usuario_db

@app.delete("/usuarios/{usuario_id}")
def eliminar_usuario(usuario_id: int, db=Depends(get_db)):
    usuario_db = db.query(Usuario).filter(Usuario.id == usuario_id).first()
    if not usuario_db:
        return {"error": "Usuario no encontrado"}
    db.delete(usuario_db)
    db.commit()
    return {"mensaje": "Usuario eliminado"}
