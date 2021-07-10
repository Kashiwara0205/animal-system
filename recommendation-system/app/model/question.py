from app.db.engine import get_engine

class Question:

  @classmethod
  def get_all(cls):
    engine = get_engine()
    conn = engine.connect()
    rows = []

    try:
      rows = conn.execute("SELECT * FROM questions")
    except e:
      print(e)
    finally:
      conn.close()
      engine.dispose()
      
    return rows

  @classmethod
  def find(cls, question_id):
    engine = get_engine()
    conn = engine.connect()
    row = None

    try:
      row = conn.execute("SELECT * FROM questions").fetchone()
    except Exception as e:
      print(e)
    finally:
      conn.close()
      engine.dispose()
      
    return row