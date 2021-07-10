import pandas as pd
import MeCab
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
from functools import reduce

class QuestionService:
  def __init__(self, question_m):
    self.question_m = question_m

  def recommendation(self, question_id):
    all_question = self.question_m.get_all()

    data_frame = {
      "id": [],
      "title": [],
      "content": []
    }
    
    m = MeCab.Tagger()

    for record in all_question:
      data_frame["id"].append(record[1])
      data_frame["title"].append(record[2])

      nouns = [line for line in m.parse(record[3]).splitlines()
               if "名詞" in line.split()[-1]]

      data_frame["content"].append(reduce(lambda a, b: a + b, nouns) )

    df = pd.DataFrame(data_frame)

    tfids = TfidfVectorizer(stop_words="english")
    tfidf_matrix = tfids.fit_transform(df['content'])
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)

    print(pd.DataFrame(tfidf_matrix.toarray(), columns=tfids.get_feature_names()), flush=True)

    indicies = pd.Series(df.index, index=df['id'])

    idx = indicies[question_id]

    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1],  reverse=True)
    sim_scores = sim_scores[1:4]
    
    question_indices = [i[0] for i in  sim_scores]
    
    return df['title'].iloc[question_indices]