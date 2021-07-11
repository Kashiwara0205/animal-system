from app.model.question import Question
from app.service.question_service import QuestionService

from flask import Flask

app = Flask(__name__)

# 類似性の高い質問を返す
# 以下の２つのフィルタリングから構成
#
#  内容ベースの類似質問
# - 類似質問の抽出 => 質問内容とタイトルをベースにしたコンテンツベースのフィルタリング
#   「似たような質問は、こちらです」といった形式で出力できる
#
#  ユーザ属性ごとの類似質問
# - 類似ユーザが作成した質問内容の抽出 => ユーザの登録情報をベースにした協調ベースのフィルタリング
#   「犬を飼っている人は、他にもこんな質問をしました」といった形式で出力できる
#
# example: curl localhost:5555/api/v1/similarity_question/3
@app.route('/api/v1/similarity_question/<int:id>', methods=['GET'])
def get_similarity_question(id):
  service = QuestionService(Question)

  res = service.recommend(id)
  print("RECOMMEND FROM CONTENT")
  print("-------------------", flush=True)
  for record in res["content_base"]:
    print(record, flush=True)
  print("-------------------", flush=True)

  print("RECOMMEND FROM TITLE")
  print("-------------------", flush=True)
  for record in res["title_base"]:
    print(record, flush=True)
  print("-------------------", flush=True)

  return 'User %d' % id

if __name__ == "__main__":
  app.run(host="0.0.0.0", port=5555, debug=True)