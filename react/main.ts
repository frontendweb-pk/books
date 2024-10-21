function Sum(a: number[]) {
  return a.reduce((first, next) => first + next, 0);
}
console.log(Sum([1, 2, 3, 4, 5, 6, 7, 8, 9]));
