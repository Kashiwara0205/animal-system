from app.db.engine import get_engine

class Question:

  @classmethod
  def get_all(cls):
    engine = get_engine()
    conn = engine.connect()
    rows = []
    try:
      result = conn.execute("\
        SELECT questions.id,\
               questions.title,\
               questions.content,\
               members.has_pet,\
               members.sex,\
               members.married\
        FROM questions \
        INNER JOIN members ON members.id = questions.member_id")

      for x in result:
        rows.append([x[0], x[1], x[2], x[3], x[4], x[5]])
      
    except Exception as e:
      print(e)
    finally:
      conn.close()
      engine.dispose()

    return rows