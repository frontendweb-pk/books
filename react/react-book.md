# Pure components

Some javascript function are pure. Pure function perform a calculation and nothing more.

`Example:`

```js
// Consider this math formula: y = 2x
// if x = 2 then y = 4
// if x = 3 then y = 6
// if x = 3, y won't sometimes be 9 or -1 or 2.5 depending on the time of day or the state of the stock market.

function double(n: number) {
  return 2 * n;
}

// OR
function Sum(a: number[]) {
  return a.reduce((first, next) => first + next, 0);
}
Sum([1, 2, 3, 4, 5, 6, 7, 8, 9]); // result: 45
```

By strictly only writing your components as pure functions.

**`Rules of pure components:`**

- `It minds its own business:` It does not change any object or variable that existed before it was called.
- `Same inputs, same outputs:` Given the same inputs, a pure function should always return the same result.

React is designed around this concept. React assumes that every component you write is a pure function.

`Example:`

```ts
// pure component
function User({ name }) {
  return (
    <div>
      <h1>Name: {name}</h1>
    </div>
  );
}

// Uses
import User from "./user";
function App() {
  return (
    <>
      <User name="Pradeep" email="pk@gmail.com" />
      <User name="Arun" email="ak@gmail.com" />
    </>
  );
}
```

When you pass `name="Pradeep"` to `User`, it will return JSX containing `Name: Pradeep`. Always

When you pass `name="Arun"` to `User`, it will return JSX containing `Name: Arun`. Always

<br />

**`Side effects: (un)intended consequences:`**

React’s `rendering process` must always be `pure`. Components should only return their `JSX`, and not change any `objects or variables` that existed before rendering.

`Example:`

```ts
// This component is breaking the rule.
let count = 0;

function Counter() {
  count = count + 1;
  return <div>Counter value: {count}</div>;
}

export default function App() {
  return (
    <>
      <Counter />
      <Counter />
      <Counter />
    </>
  );
}
```

This component is reading and wring a `count` variable declared outside of it. This means that calling this component multiple times will produce different JSX!. the result of calling component is not predictable.

Fix this passing `count` as props

```ts
function Counter({ count }) {
  return <div>Counter value: {count}</div>;
}

export default function App() {
  return (
    <>
      <Counter count={1} />
      <Counter count={2} />
      <Counter count={3} />
    </>
  );
}
```

Now your component is pure, as the JSX it returns only depends on the `count` prop.

<br />

**`Detecing impure calculations with StrictMode:`**

In React,

There are three kind of inputs that you can read while rendering.

- `Props`
- `State`
- `Context`

You shold always treat these inputs a read-only.
