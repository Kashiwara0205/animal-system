# coding: utf-8

import pandas as pd
import MeCab
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import linear_kernel
from sklearn.metrics.pairwise import cosine_similarity
from functools import reduce

class QuestionService:
  def __init__(self, question_m):
    self.question_m = question_m

  def recommend(self, question_id):
    all_question = self.question_m.get_all()
    question_df = self.__create_question_df(all_question)
    member_df = self.__create_member_df(all_question)

    return {
      "content_base": self.__question_based_recommend(question_df, "content_nouns", question_id),
      "title_base": self.__question_based_recommend(question_df, "title_nouns", question_id),
      "member_base": self.__member_based_recommend(member_df, question_id)
    }

  def __create_question_df(self, all_question):
    data_frame = {
      "id": [],
      "title": [],
      "title_nouns": [],
      "content_nouns": []
    }

    for record in all_question:
      data_frame["id"].append(record[0])
      data_frame["title"].append(record[1])

      nouns = self.__get_nouns(record[1])
      data_frame["title_nouns"].append(reduce(lambda a, b: a + b, nouns) )

      nouns = self.__get_nouns(record[2])
      data_frame["content_nouns"].append(reduce(lambda a, b: a + b, nouns) )

    return pd.DataFrame(data_frame)

  def __create_member_df(self, all_question):
    data_frame = {
      "id": [],
      "title": [],
      "member_soup": [],
    }

    for record in all_question:
      data_frame["id"].append(record[0])
      data_frame["title"].append(record[1])
      data_frame["member_soup"].append(self.__create_member_soup(record[3], record[4], record[5]))

    return pd.DataFrame(data_frame)

  def __create_member_soup(self, has_pet, sex, married):
    formatted_has_pet = self.__format_pet(has_pet)
    formatted_married = self.__format_married(married)
    return formatted_has_pet + " " + sex + " " + formatted_married

  def __format_pet(self, has_pet):
    return "ペット有り" if has_pet else "ペット無し"

  def __format_married(self, married):
    return "結婚歴有り" if married else "結婚歴無し"

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
    
    titles = []
    for x in df['title'].iloc[question_indices]:
      titles.append(x)

    return titles

  def __member_based_recommend(self, df, question_id):
    count = CountVectorizer()

    count_matrix = count.fit_transform(df['member_soup'])
    cosine_sim = cosine_similarity(count_matrix, count_matrix)

    indicies = pd.Series(df.index, index=df['id'])

    idx = indicies[question_id]

    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1],  reverse=True)
    sim_scores = sim_scores[1:4]
    
    question_indices = [i[0] for i in  sim_scores]

    titles = []
    for x in df['title'].iloc[question_indices]:
      titles.append(x)

    return titles