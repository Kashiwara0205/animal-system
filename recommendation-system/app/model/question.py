from app.db.connection import get_connection

class Question:

  @classmethod
  def get_all(cls):
    conn = get_connection()
    cur = conn.cursor()

    rows = []
    try:
      cur.execute("\
        SELECT questions.id,\
               questions.title,\
               questions.content,\
               members.has_pet,\
               members.sex,\
               members.married\
        FROM questions \
        INNER JOIN members ON members.id = questions.member_id")

      rows = cur.fetchall()
    except Exception as e:
      print(e)
    finally:
      conn.close()

    return rows