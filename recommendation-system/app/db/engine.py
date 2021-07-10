import sqlalchemy as sa

def get_engine():
  url = 'mysql+pymysql://root:password@db/animals?charset=utf8'
  return sa.create_engine(url, echo=False)