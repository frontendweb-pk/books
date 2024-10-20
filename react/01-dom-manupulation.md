# Manipulating the DOM with Refs

React autometically updates the `DOM` to match the your render output. so your component won't often need to manipulate it.

However, sometimes you might need access to the DOM elements managed by React—for example, to focus a node, scroll to it, or measure its size and position.

There is no built-in way to do those things in React, so you will need a `ref` to the `DOM` node.

`Use ref to the node:`

```ts
// first import
import { useRef } from "react";

// create component
export default function User() {
  // declare ref
  const elRef = useRef(null);

  //use ref to access ref attribute to the tag
  return <div ref={elRef}></div>;
}
```

`Example:`

`Create useFocus hook for re-use using ref:`

```ts
import { useRef } from "react";

export default function useFocus<T extends HTMLElement>() {
  const elemRef = useRef<T>(null);

  useEffect(() => {
    ref.current.focus();
  }, []);

  return ref;
}
```
