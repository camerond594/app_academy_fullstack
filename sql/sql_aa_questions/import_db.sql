PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  body TEXT,

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
  FOREIGN KEY (parent_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL

  FOREIGN KEY (user_id) REFERENCES users(id)
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO users('fname','lname')
VALUES ('John','Smith'),('Crazy','Boy');

INSERT INTO questions('title','body','author_id')
VALUES ('Some','Handsome?',1),('dumb one','why am i a boy?',2),
('Hand','What is this?',1),('Test','Is this a test?', 2),
('Test2','Test again?',1),('Test3','Test again again?',2);

INSERT INTO question_followers('question_id','user_id')
VALUES (1,2),(2,1),(1,1);

INSERT INTO replies('reply','author_id','question_id','parent_id')
VALUES ('YES!',2,1,NULL),('because of genetics?',1,2,NULL),('huh?',1,1,1);

INSERT INTO question_likes('question_id','user_id')
VALUES (1,2),(2,1),(1,1),(1,2),(3,1),(4,2),(4,1),(5,1),(5,2),(5,1),(5,2);
