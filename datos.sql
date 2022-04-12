-- (1)Crear base de datos llamada blog
CREATE DATABASE blog_db;
-- (2)Crear las tablas indicadas de acuerdo al modelo de datos
CREATE TABLE usuarios (
  id SERIAL NOT NULL PRIMARY KEY,
  email VARCHAR(255) NOT NULL
);
CREATE TABLE posts (
  id SERIAL NOT NULL PRIMARY KEY,
  usuario_fk INT NOT NULL, 
  titulo VARCHAR(255) NOT NULL,
  fecha DATE NOT NULL,
  FOREIGN KEY (usuario_fk) REFERENCES usuarios(id)
);
CREATE TABLE comentarios (
  id SERIAL NOT NULL PRIMARY KEY,
  post_fk INT NOT NULL,
  usuario_fk INT NOT NULL,
  texto TEXT NOT NULL,
  fecha DATE NOT NULL,
  FOREIGN KEY (post_fk) REFERENCES posts(id),
  FOREIGN KEY (usuario_fk) REFERENCES usuarios(id)
);
-- (3)Insertar los siguientes registros
\copy usuarios FROM 'C:\Users\Lenovo i5\Desktop\blog\usuarios.csv' csv header;
\copy posts FROM 'C:\Users\Lenovo i5\Desktop\blog\posts.csv' csv header;
\copy comentarios FROM 'C:\Users\Lenovo i5\Desktop\blog\comentarios.csv' csv header;
-- (4)Seleccionar el correo, id y título de todos los post publicados por el usuario 5
SELECT email, usuarios.id, titulo FROM usuarios inner join posts on usuarios.id = posts.usuario_fk where usuarios.id =5;
-- (5)Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com
select email, usuarios.id, texto from comentarios left join usuarios on comentarios.usuario_fk = usuarios.id where usuarios.email != 'usuario06@hotmail.com';
-- (6)Listar los usuarios que no han publicado ningún post
select * from usuarios full outer join posts on usuarios.id = posts.usuario_fk where usuarios.id is null or posts.usuario_fk is null;
-- (7)Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios)
select titulo, texto from posts full outer join comentarios on posts.id = comentarios.post_fk;
-- (8)Listar todos los usuarios que hayan publicado un post en Junio
select * from usuarios left join posts on posts.usuario_fk  = usuarios.id where posts.fecha between '2020-06-01' and '2020-06-30';