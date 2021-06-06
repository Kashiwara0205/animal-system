import Question from "../../../app/javascript/model/question"

test('getListUrlで返却されるURLを担保する', () => {
  const model = new Question
  expect(model.getListUrl()).toBe("/api/v1/questions");
});