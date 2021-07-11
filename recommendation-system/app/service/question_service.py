import pandas as pd
import MeCab
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel
from functools import reduce

class QuestionService:
  def __init__(self, question_m):
    self.question_m = question_m

  def recommend(self, question_id):
    all_question = self.question_m.get_all()
    question_df = self.__create_question_df(all_question)

    return {
      "content_base": self.__question_based_recommend(question_df, "content_nouns", question_id),
      "title_base": self.__question_based_recommend(question_df, "title_nouns", question_id),
    }

  def __create_question_df(self, all_question):
    data_frame = {
      "id": [],
      "title": [],
      "title_nouns": [],
      "content_nouns": []
    }

    for record in all_question:
      data_frame["id"].append(record[1])
      data_frame["title"].append(record[2])

      nouns = self.__get_nouns(record[2])
      data_frame["title_nouns"].append(reduce(lambda a, b: a + b, nouns) )

      nouns = self.__get_nouns(record[3])
      data_frame["content_nouns"].append(reduce(lambda a, b: a + b, nouns) )

    return pd.DataFrame(data_frame)

  def __get_nouns(self, column):
    m = MeCab.Tagger()
    return [line for line in m.parse(column).splitlines() if "名詞" in line.split()[-1]]

  def __question_based_recommend(self, df, key, question_id):
    tfids = TfidfVectorizer()
    tfidf_matrix = tfids.fit_transform(df[key])
    cosine_sim = linear_kernel(tfidf_matrix, tfidf_matrix)

    indicies = pd.Series(df.index, index=df['id'])

    idx = indicies[question_id]

    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1],  reverse=True)
    sim_scores = sim_scores[1:4]
    
    question_indices = [i[0] for i in  sim_scores]
    
    return df['title'].iloc[question_indices]