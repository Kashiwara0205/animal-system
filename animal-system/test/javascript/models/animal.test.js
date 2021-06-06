import Animal from "../../../app/javascript/model/animal"

test('getListUrlで返却されるURLを担保する', () => {
  const model = new Animal
  expect(model.getListUrl()).toBe("/api/v1/animals");
});

test('getCsvUrlで返却されるURLを担保する', () => {
  const model = new Animal
  expect(model.getCsvUrl()).toBe("/api/v1/animals/csv");
});

test('getUpdateUrlで返却されるURLを担保する', () => {
  const model = new Animal
  expect(model.getUpdateUrl()).toBe("/api/v1/animals");
});
