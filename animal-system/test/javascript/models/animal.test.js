import Animal from "../../../app/javascript/model/animal"

test('getListUrlで返却されるURLを担保する', () => {
  const model = new Animal
  expect(model.getListUrl()).toBe("/api/v1/animals");
});
