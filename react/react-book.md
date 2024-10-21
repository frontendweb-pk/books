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

When you want to change something in response to user input, you should set state instead of writing to a variable.

`Note:`

You should never change preexisting variables or objects while your component is rendering.

<br />

`Stri Mode:`

- It calls each component's function twice during development.
- By calling the component functions twice, Strict Mode helps find components that break these rules.
- It has no effect in production, so it won't shlow down the app for your users.

<br />

**`Local mutation:`**

the problem was that the component changed a preexisting variable while rendering. This is often called a `“mutation”` to make it sound a bit scarier.

Pure functions don’t `mutate` variables `outside` of the function’s `scope` or objects that were created before the call—that makes them `impure!`.

However, it’s completely fine to change variables and objects that you’ve just created while rendering

`Example:`

```ts
function Todo({ text }) {
  return <p>{text}</p>;
}

export default function TodoList() {
  const todos = [];
  for (let i = 0; i <= 10; i++) {
    todos.push(<Todo text={n} key={n} />);
  }
  return todos;
}
```

If the `todos` variable or the [] array were created outside the `TodoList` function, this would be a huge problem! You would be changing a preexisting object by pushing items into that array.

it’s fine because you’ve created them during the same render, inside `TodoList`. No code outside of the `TodoList. This is called `“local mutation”`—it’s like your component’s little secret.

<br />

**`Adding side effect:`**

Functional programming relies havily on purity, at some point, somewhere, something has to change.

That's kind of point in the programming! there changes -- updating the `screen`, starting an `animation`, chaning the `data` - are called `side effects.`

They’re things that happen `“on the side”`, not during `rendering`.

In React, side effect usually belong inside `event handlers`.

`Event handlers` are functions that React runs when you perform some action -- for example, when you click a button. Even though event handlers are defined inside your component, they don’t run during rendering! So event handlers don’t need to be `pure`.

If you’ve exhausted all other options and can’t find the right event handler for your side effect, you can still attach it to your returned JSX with a `useEffect` call in your component. This tells React to execute it later, after rendering, when side effects are allowed. However, this approach should be your `last resort`.
