# Commands:
"""
python -m venv fastapienv   Create an environment for FastAPI
cd fastapienv/Scripts   activate   Activate the environment
pip install fastapi[all]   Install all fastapi dependencies
uvicorn books:app --reload   Start FastAPI app
http://127.0.0.1:8000/   Root
http://127.0.0.1:8000/openapi.json   OpenAPI specification which describes your RESTful APIs
http://127.0.0.1:8000/docs   Swagger UI

SQLite3:
   Download SQLite3 Precompiled Binaries for Windows win32-x86: https://www.sqlite.org/download.html
      Install it in C:\ and then add it to Path System Variables like this: C:\sqlite3
         Execute it using 
    sqlite3 my_db.db   Opens a SQLite shell enabling the interacting with the database db_name.db
    .schema   Shows the schema for all the tables in the database
    .mode table   Change the display from the SELECT clause to `table`
    .quit   Exits SQLite shell
    INSERT INTO my_db (my_col_1, my_col_2) values (my_val_1, my_val_2);   Insert values
    SELECT * FROM my_db;   Select values
    DELETE FROM my_db WHERE my_col = an_int;
    DROP TABLE my_table;
"""

# Imports
from fastapi import FastAPI, HTTPException, Request, status, Form, Header, Depends
from enum import Enum
from typing import Optional
from pydantic import BaseModel, Field
from starlette.responses import JSONResponse
from uuid import UUID
from sqlalchemy import create_engine, Boolean, Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import sessionmaker, Session, relationship
from sqlalchemy.ext.declarative import declarative_base
from database import Base


# Setting up API
app = FastAPI()


# Setting up SQLAlchemy ORM (Object Relational Mapping) with SQLite DBMS (Database Management System)
SQLALCHEMY_DATABASE_URL = "sqlite:///./todos.db"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={
        "check_same_thread": False
    }
)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine
)

Base = declarative_base()

Base.metadata.create_all(bind=engine)

class MyTable(Base):
    # By default the __tablename__ converts the class name to lowercase and use underscores instead of camel case
    __tablename__ = "my_table_name"

    my_id = Column(Integer, primary_key=True, index=True)
    my_str_col = Column(String(n_characters), unique=True)
    my_int_col = Column(Integer, nullable=False)
    my_bool_col = Column(Boolean, default=False)

def get_db():
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()


# SQLAlchemy models relationships
class MyCustomer(Base):
    __tablename__ = "my_customer"
    my_id = Column(Integer, primary_key=True, index=True)
    my_first_name = Column(String[40], nullable=False)

    my_order_relation = relationship("MyOrder", back_populates="my_customer_relation")

class MyOrder(Base):
    __tablename__ = "my_order"
    my_id = Column(Integer, primary_key=True, index=True)
    my_value = Column(Float, nullable=False)

    my_customer_id = Column(Integer, ForeignKey("my_customer.my_id"))
    my_customer_relation = relationship("MyCustomer", back_populates="my_order_relation")


# ORM commands
db.query(MyTable).all()
db.query(MyTable).filter(MyTable.id == an_int).first()
db.add(my_new_obj)
db.commit()


# Simple get
@app.get("/")
async def my_func():
    return my_dict


# Get with parameter
@app.get("/{my_resource}")
async def my_func(my_resource: my_type):
    return my_dict[my_resource]
# my_resource in decorator and in function definition doesn't have match


# Get with parameter and optional value
@app.get("/{my_resource}")
async def my_func(my_resource: Optional[a_type]=None):
    if my_resource:
        return my_dict_1
    else:
        return my_dict_2


# Get with parameter and default/optional value
@app.get("/{my_resource}")
async def my_func(my_resource: my_type="my_default_value"):
    return my_dict[my_resource]


# Get with custom list of possible values
class MyClass(str, Enum):
    my_possibility_1 = "My Possibility 1"
    my_possibility_2 = "My Possibility 2"

@app.get("/{my_obj}")
async def my_func(my_obj: MyClass):
    if my_obj == MyClass.my_possibility_1:
        return my_dict_1
    if my_obj == MyClass.my_possibility_2:
        return my_dict_2
    return my_dict_3


# Get with header
@app.get("/my_path")
async def my_func(my_var: Optional[str] = Header(None)):
    return {"my_var": my_var}
# Header class can be a useful way to define endpoints that require custom HTTP headers to be included in the request.


# Get with database
@app.get("/")
async def my_func(db: Session = Depends(get_db)):
    return db.query(MyTable).all()


# Simple post
@app.post("/")
async def my_func(my_var_1, my_var_2):
    my_dict[my_var_1] = my_var_2
    return my_dict


# Post with data type validation
class MyClass(BaseModel):
    my_UUID: UUID
    my_str_attribute: str
    my_int_attribute: int

@app.post("/")
async def create_book(my_obj: MyClass):
    my_list.append(my_obj)
    return my_obj


# Post with data type validation and other validations
class MyClass(BaseModel):
    my_UUID: str
    my_str_attribute: Optional[str] = Field(
        title="My details about this attribute",
        max_length=100,
        min_length=1
    )
    my_int_attribute: int = Field(
        gt=-1,
        lt=101
    )

@app.post("/")
async def create_book(my_obj: MyClass):
    my_list.append(my_obj)
    return my_obj


# Post with data type validation and other validations, and pre-defined data example
class MyClass(BaseModel):
    my_UUID: str
    my_str_attribute: Optional[str] = Field(
        title="My details about this attribute",
        max_length=100,
        min_length=1
    )
    my_int_attribute: int = Field(
        gt=-1,
        lt=101
    )

    class Config:
        schema_extra = {
            "example": {
                "my_UUID": "576b164d-b05f-4bfe-ba6c-db1da286372f",
                "my_str_attribute": "A description of a book",
                "my_int_attribute": 75,
            }
        }

@app.post("/")
async def create_book(my_obj: MyClass):
    my_list.append(my_obj)
    return my_obj


# Post with custom status code response
@app.post("/", status_code=status.HTTP_201_CREATED)
async def my_func(my_var_1, my_var_2):
    my_dict[my_var_1] = my_var_2
    return my_dict


# Post with Form field
@app.post("/books/login")
async def my_func(my_var_1: str = Form(), my_var_2: str = Form()):
    return {"my_var_1": my_var_1, "my_var_2": my_var_2}
# Form fields is a convenient way to accept data from HTML forms in your API endpoints. But FastAPI also provides
# support for other types of request data, including JSON-encoded data, query parameters, and path parameters.


# Post with database
class MyClass(BaseModel):
    my_UUID: UUID
    my_str_attribute: str
    my_int_attribute: int

@app.post("/")
async def my_func(my_obj: MyClass, db: Session = Depends(get_db)):
    my_new_obj = MyTable()
    my_new_obj.my_int_attribute = my_obj.my_int_attribute
    my_new_obj.my_str_attribute = my_obj.my_str_attribute

    db.add(my_new_obj)
    db.commit()

    return {
        "status": 201,
        "transaction": "Successful"
    }


# Simple put 
@app.put("/{my_resource}")
async def my_func(my_resource: a_type, my_obj: MyClass):
    my_dict[my_resource] = my_obj
    return my_dict 


# Put with database
@app.put("/{my_resource}")
async def my_func(my_resource: a_type, my_obj: MyClass, db: Session = Depends(get_db)):
    my_updated_obj = (
        db
        .query(MyTable)
        .filter(MyTable.id == an_int)
        .first()
    )
    
    my_updated_obj.my_int_attribute = my_obj.my_int_attribute
    my_updated_obj.my_str_attribute = my_obj.my_str_attribute

    db.add(my_updated_obj)
    db.commit()

    return {
        "status": 200,
        "transact": "Successful"
    }


# Simple delete
@app.delete("/{my_resource}")
async def my_func(my_resource):
    del my_dict[my_resource]
    return f"My resource {my_resource} was deleted."


# Delete with database
@app.delete("/{todo_id}")
async def delete_todo(my_resource: a_type, db: Session = Depends(get_db)):
    db.query(MyTable).filter(MyTable.id == an_int).delete()
    db.commit()

    return {
        "status": 200,
        "transact": "Successful"
    }


# Handling exceptions using HTTPException which can be used for simple exceptions
def item_cannot_be_found_exception():
    return HTTPException(
        status_code=404,
        detail="Resource not found",
        headers={"X-Header-Error": "Nothing to be seen at the UUID"}
    )

@app.get("/{my_resource}")
async def my_func(my_resource: my_type):
    try:
        my_dict[my_resource]
    except KeyError:
        raise item_cannot_be_found_exception()
    return my_dict[my_resource]

@app.put("/{my_resource}")
async def update_book(my_resource: a_type, my_obj: MyClass):
    try:
        my_dict[my_resource] = my_obj
    except KeyError:
        raise item_cannot_be_found_exception()
    return my_dict

@app.delete("/{my_resource}")
async def delete_book(my_resource):
    try:
        del my_dict[my_resource]
    except KeyError:
        raise item_cannot_be_found_exception()
    return f"My resource {my_resource} was deleted."


# Handling exceptions using exception_handler which is preferable and shoud be used for complex exceptions
class NegativeNumberException(Exception):
    def __init__(self, n_items_to_return):
        self.n_items_to_return = n_items_to_return

@app.exception_handler(NegativeNumberException)
async def negative_number_exception_handler(request: Request,
                                            exception: NegativeNumberException):
    return JSONResponse(
        status_code=400,
        content={"message": "You entered {exception.n_items_to_return} but the number must be positive"}
    )
# the request parameter is not mandatory but it is a standard
# part of the exception handler function signature in FastAPI


# Using response_model
class MyClass(BaseModel):
    my_UUID: UUID
    my_str_attribute: str
    my_int_attribute: int

class MyClassNoInt(BaseModel):
    my_UUID: UUID
    my_str_attribute: str

@app.get("/{my_resource}")
async def my_func(my_resource: my_type):
    return my_dict[my_resource]

@app.get("/no_int/{my_resource}", response_model=MyClassNoInt)
async def my_func(my_resource: my_type):
    return my_dict[my_resource]
# response_model defines the expected JSON response format for an API endpoint.


# Concepts:
#   Difference between query and path parameters:
#       Query parameters are used to filter or modify data, and are optional, while
#       path parameters are used to identify a specific resource, and are mandatory.
#   JWT (Json Web Token)
#       Used for authorization. It securely transmits data between two parties using a JSON Object.
