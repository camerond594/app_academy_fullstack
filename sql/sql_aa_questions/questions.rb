require 'sqlite3'
require 'singleton'

class QuestionDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :title, :author_id, :body
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @author_id = options['author_id']
    @body = options['body']

  end

  def self.find_by_id(id)
    question_data =  QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    return nil unless question_data.length > 0

    return Question.new(question_data[0])
  end

  def self.find_by_author_id(author_id)
    author_questions = QuestionDBConnection.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    return nil unless author_questions.length > 0

    author_questions.map { |data| Question.new(data) }
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end

class User
  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    user_data =  QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    return nil unless user_data.length > 0

    User.new(user_data[0])
  end

  def self.find_by_name(fname, lname)
    user_by_name = QuestionDBConnection.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    return nil unless user_by_name.length > 0

    user_by_name.map { |data| User.new(data) }
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

end

class QuestionFollower
  attr_accessor :user_id, :question_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    question_follower_data =  QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_followers
      WHERE
        id = ?
    SQL

    return nil unless question_follower_data.length > 0

    QuestionFollower.new(question_follower_data[0])
  end

  def self.followers_for_question_id(question_id)
    question_follower_data =  QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users LEFT JOIN question_followers
        ON
          users.id = question_followers.user_id
      WHERE
        question_id = ?
    SQL

    return nil unless question_follower_data.length > 0

    question_follower_data.map { |data| User.new(data) }
  end

  def self.followed_questions_for_user_id(user_id)
    question_follower_data =  QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions LEFT JOIN question_followers
        ON
          questions.id = question_followers.question_id
      WHERE
        user_id = ?
    SQL

    return nil unless question_follower_data.length > 0

    question_follower_data.map { |data| Question.new(data) }
  end

  def self.most_followed_questions(n)
    question_follower_data =  QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        *, COUNT(question_followers.user_id)
      FROM
        question_followers JOIN questions
        ON
          questions.id = question_followers.question_id
      GROUP BY
        question_followers.question_id
      ORDER BY
        COUNT(question_followers.user_id) DESC
      LIMIT ?
    SQL

    return nil unless question_follower_data.length > 0

    question_follower_data.map { |data| Question.new(data) }
  end

end

class QuestionLike
  attr_accessor :user_id, :question_id
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    question_like_data =  QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    return nil unless question_like_data.length > 0

    QuestionLike.new(question_like_data[0])
  end

  def self.likers_for_question_id(question_id)
    question_like_data = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        u.*
      FROM
        question_likes AS ql JOIN users AS u
          ON ql.user_id = u.id
      WHERE
        question_id = ?
    SQL

    return nil unless question_like_data.length > 0

    question_like_data.map { |data| User.new(data) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(u.id) AS likes
      FROM
        question_likes AS ql JOIN users AS u
          ON ql.user_id = u.id
      WHERE
        question_id = ?
    SQL

    return nil unless num_likes.length > 0
    num_likes[0]['likes']
  end

  def self.liked_questions_for_user_id(user_id)
    liked_questions = QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        q.*
      FROM
        question_likes AS ql JOIN questions AS q
          ON ql.question_id = q.id
      WHERE
        user_id = ?
      GROUP BY
        q.id
    SQL

    return nil unless liked_questions.length > 0

    liked_questions.map { |data| Question.new(data) }
  end

  def self.most_liked_questions(n)
    question_like_data =  QuestionDBConnection.instance.execute(<<-SQL, n)
      SELECT
        q.*, COUNT(ql.user_id)
      FROM
        question_likes AS ql JOIN questions AS q
        ON
          q.id = ql.question_id
      GROUP BY
        ql.question_id
      ORDER BY
        COUNT(ql.user_id) DESC
      LIMIT ?
    SQL

    return nil unless question_like_data.length > 0

    question_like_data.map { |data| Question.new(data) }
  end
end

class Reply
  attr_accessor :parent_id, :author_id, :question_id, :reply
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @reply = options['reply']
    @parent_id = options['parent_id']
    @author_id = options['author_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    reply_data =  QuestionDBConnection.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    return nil unless reply_data.length > 0

    Reply.new(reply_data[0])
  end

  def self.find_by_user_id(user_id)
    user_id_replies =  QuestionDBConnection.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        author_id = ?
    SQL

    return nil unless user_id_replies.length > 0

    user_id_replies.map { |data| Reply.new(data) }
  end

  def self.find_by_question_id(question_id)
    question_id_replies =  QuestionDBConnection.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    return nil unless question_id_replies.length > 0

    question_id_replies.map { |data| Reply.new(data) }
  end

  def self.find_children_by_parent_id(parent_id)
    child_replies =  QuestionDBConnection.instance.execute(<<-SQL, parent_id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL

    return nil unless child_replies.length > 0

    child_replies.map { |data| Reply.new(data) }
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    Reply.find_children_by_parent_id(@id)
  end
end
