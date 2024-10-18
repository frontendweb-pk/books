# What is refs in react?

`Refs` provide a way to access `DOM` nodes or React elements created in the render method.

When you want a component to `remember` some information, but you don’t want that information to trigger `new` `renders`, you can use a `ref`.

**`When to use Refs:`**

- Managing focus, text selection and media playback.
- Triggering impretive animations.
- Integrating with third-party DOM library.

**`How to add Refs:`**

You can add a `ref` to your component by importing the `useRef` Hook.

<br />

`Examples:`

- **`Accessing DOM Elements:`**

  ```ts
  import { useRef } from "react";

  // Accessing DOM Elements
  export default function Heading() {
    // ref
    const divRef = useRef<HTMLInputElement | null>(null); // accessing the dom of div
    return (
      <div ref={divRef}>
        <h1>Hello world! </h1>
      </div>
    );
  }

  // or

  function Input() {
    const inputRef = useRef<HTMLInputElement | null>(null);

    const handleFocus = () => inputRef.current?.focus();

    return (
      <div>
        <input ref={inputRef} type="text" placeholder="Type here..." />
        <button onClick={handleFocus}>Focus Input</button>
      </div>
    );
  }
  ```

- **`Storing mutable values:`**

  `useRef` can hold mutable values that don't trigger `re-renders` when changed.
  This is useful for storing a `previous value`, keeping track of timers, or managing any value that needs to persist across renders without causing updates.

  ```ts
  export default function PreviousCount({ count }: { count: number }) {
    const prevCountRef = useRef<number | null>(count);

    // Uses useRef to keep track of the last count value.
    useEffect(() => {
      prevCountRef.current = count;
    }, [count]);

    return (
      <div>
        Counter previous value : {prevCountRef.current}, next value:{count}
      </div>
    );
  }
  ```

- **`Keeping a Reference to a Value Across Renders:`**

  When you need a reference to a value that doesn't need to trigger `re-renders`, such as a timeout ID or an external library instance, `useRef` is the way to go.

  ```ts
  import React, { useEffect, useRef, useState } from "react";

  function Timer() {
    const [count, setCount] = useState(0);
    const timerRef = useRef<number | null>(null);

    useEffect(() => {
      timerRef.current = window.setInterval(() => {
        setCount((prev) => prev + 1);
      }, 1000);

      return () => {
        if (timerRef.current) {
          clearInterval(timerRef.current);
        }
      };
    }, []);

    return <div>Timer Count: {count}</div>;
  }

  export default Timer;
  ```

`Examples:`

**`Stop watch:`**

`Example:`

```ts
import { useRef, useState } from "react";

export default function Stopwatch() {
  const [startTime, setStartTime] = useState<number | null>(null);
  const [now, setNow] = useState<number | null>(null);

  const timerRef = useRef<number | null>(null);

  const handleStart = () => {
    setStartTime(Date.now());
    setNow(Date.now());

    clearInterval(timerRef.current!);

    timerRef.current = setInterval(() => {
      setNow(Date.now());
    }, 10);
  };
  const handleStop = () => {
    clearInterval(timerRef.current!);
  };

  let timer = 0;
  if (startTime !== null && now !== null) {
    timer = (now - startTime) / 1000;
  }

  return (
    <div>
      <span>timer: {timer.toFixed(2)}</span>
      <button onClick={handleStart}>Start</button>
      <button onClick={handleStop}>Stop</button>
    </div>
  );
}
```

**`Advanced Use cases:`**

**`Persisting Values Across Renders:`**

`useRef` can be used to keep values consistent across renders without triggering re-renders, making it useful for storing API response data or flags.

```ts
import React, { useEffect, useRef, useState } from "react";

function MouseTracker() {
  const [position, setPosition] = useState({ x: 0, y: 0 });
  const mousePosRef = useRef({ x: 0, y: 0 });

  useEffect(() => {
    const handleMouseMove = (event: MouseEvent) => {
      const { clientX, clientY } = event;
      setPosition({ x: clientX, y: clientY });
      mousePosRef.current = { x: clientX, y: clientY };
    };

    window.addEventListener("mousemove", handleMouseMove);
    return () => {
      window.removeEventListener("mousemove", handleMouseMove);
    };
  }, []);

  return (
    <div>
      <p>Current Position: {`X: ${position.x}, Y: ${position.y}`}</p>
      <p>
        Last Position:
        {`X: ${mousePosRef.current.x}, Y: ${mousePosRef.current.y}`}
      </p>
    </div>
  );
}

export default MouseTracker;
```

**`Integrating with Third-Party Libraries:`**

`useRef` is particularly useful when you need to integrate React with non-React libraries, such as charting libraries or DOM manipulation libraries.

```ts
import React, { useEffect, useRef } from "react";
import Chart from "chart.js";

function ChartComponent() {
  const canvasRef = useRef<HTMLCanvasElement | null>(null);

  useEffect(() => {
    const ctx = canvasRef.current?.getContext("2d");
    if (!ctx) return;

    const myChart = new Chart(ctx, {
      type: "bar",
      data: {
        labels: ["Red", "Blue", "Yellow"],
        datasets: [
          {
            label: "# of Votes",
            data: [12, 19, 3],
            backgroundColor: [
              "rgba(255, 99, 132, 0.2)",
              "rgba(54, 162, 235, 0.2)",
              "rgba(255, 206, 86, 0.2)",
            ],
            borderColor: [
              "rgba(255, 99, 132, 1)",
              "rgba(54, 162, 235, 1)",
              "rgba(255, 206, 86, 1)",
            ],
            borderWidth: 1,
          },
        ],
      },
      options: {
        scales: {
          y: {
            beginAtZero: true,
          },
        },
      },
    });

    return () => {
      myChart.destroy();
    };
  }, []);

  return <canvas ref={canvasRef} width={400} height={400}></canvas>;
}

export default ChartComponent;
```

`Note:`

- Changing the value of `ref.current` does not trigger a re-render, which makes it suitable for storing values that should not cause the component to update.

- The `ref` object persists for the full lifetime of the component, retaining its value across re-renders.

- When used with a ref attribute, it can reference a DOM element directly.

<br />

When a piece of information is used for rendering, keep it in state. When a piece of information is only needed by event handlers and changing it doesn’t require a re-render, using a ref may be more efficient.

<br />

**`Differences between refs and state:`**

| Refs                                                                                  | State                                                                                                               |
| ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| useRef(intialValue) returns {current:initialValue}                                    | useState(initialValue) returns the current value of a state variable and a state setter function ([value,setValue]) |
| Does'nt trigger re-render when you change it                                          | Triggers re-render when you change it                                                                               |
| Mutable-- you can modify and update current's value outside of the rendering process. | "immutable"-- you must use the state setter function to modify state variables to queue a re-render                 |
| You shouldn’t read (or write) the current value during rendering.                     | You can read state at any time. However, each render has its own snapshot of state which does not change.           |

<br />

**`How does useRef work inside?:`**

Although both useState and `useRef` are provided by React, in principle useRef could be implemented on top of useState. You can imagine that inside of React, `useRef` is implemented like this:

```ts
// Inside of React
function useRef(initialValue) {
  const [ref, unused] = useState({ current: initialValue });
  return ref;
}
```

During the first render, useRef returns `{ current: initialValue }`. This object is stored by React,
so during the next render the same object will be returned.
