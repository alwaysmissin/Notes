# 异步JavaScript
## 简介
- 异步编程技术使程序可以在执行一个可能长期运行的任务的同时继续对其他时间做出反应而不必等待当前任务完成

## 使用`fetch()`
- 向服务器发起HTTP请求
- 一个现代的、基于Promise的、用于替代`XMLHttpRequest`的方法

## 链式使用Promise
- `then()`本身也会返回一个Promise
```js
const fetchPromise = fetch('https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json');

fetchPromise
  .then( response => {
    return response.json();
  })
  .then( json => {
    console.log(json[0].name);
  });

```
- 不必在第一个 `then()` 的处理程序中调用第二个 `then()`，我们可以直接_返回_ `json()` 返回的 Promise，并在该返回值上调用第二个 `then()`。这被称为 **Promise 链**，意味着当我们需要连续进行异步函数调用时，我们就可以避免不断嵌套带来的缩进增加。


## 错误捕获
- Promise对象提供了一个`catch()`方法来支持错误处理
- 这很像 `then()`：你调用它并传入一个处理函数。然后，当异步**操作成功时**，传递给 `then()` 的处理函数被调用，而当异步操作失败时，传递给 `catch()`的处理函数被调用。

## Promise术语
- Promise的三种状态
	- 待定
		- `pending`
		- 初始状态，既没有被兑现，也没有被拒绝。这是调用 `fetch()` 返回 Promise 时的状态，此时请求还在进行中
	- 已兑现
		- `fulfilled`
		- 意味着操作成功完成。当 Promise 完成时，它的 `then()` 处理函数被调用
	- 已拒绝
		- `rejected`
		- 意味着操作失败。当一个 Promise 失败时，它的 `catch()` 处理函数被调用
> 有时我们用 **已敲定（settled）** 这个词来同时表示 **已兑现（fulfilled）** 和 **已拒绝（rejected）** 两种情况
> 如果一个 Promise 处于已决议（resolved）状态，或者它被“锁定”以跟随另一个 Promise 的状态，那么它就是 **已兑现（fulfilled）**。

## 合并使用多个Promise
- 有时你需要所有的 Promise 都得到实现，但它们并不相互依赖
- `Promise.all()`方法接受一个Promise数组，并返回一个单一的Promise
- 由`Promise.all()`返回的Promise：
	- 当且仅当数组中_所有_的 Promise 都被兑现时，才会通知 `then()` 处理函数并提供一个包含所有响应的数组，数组中响应的顺序与被传入 `all()` 的 Promise 的顺序相同。
	- 会被拒绝——如果数组中有**任何一个**Promise 被拒绝。此时，`catch()` 处理函数被调用，并提供被拒绝的 Promise 所抛出的错误。
- `Promise.any()`：在 Promise 数组中的任何一个被兑现时它就会被兑现，如果所有的 Promise 都被拒绝，它也会被拒绝

## async和await
- 在一个函数的开头添加`async`，就可以使其成为一个异步函数
- 在异步函数中，你可以在调用一个返回 Promise 的函数之前使用 `await` 关键字
	- 这使得代码在该点上等待，直到 Promise 被完成，这时 Promise 的响应被当作返回值，或者被拒绝的响应被作为错误抛出
```sql
async function fetchProducts() {
  try {
    // 在这一行之后，我们的函数将等待 `fetch()` 调用完成
    // 调用 `fetch()` 将返回一个“响应”或抛出一个错误
    const response = await fetch('https://mdn.github.io/learning-area/javascript/apis/fetching-data/can-store/products.json');
    if (!response.ok) {
      throw new Error(`HTTP 请求错误：${response.status}`);
    }
    // 在这一行之后，我们的函数将等待 `response.json()` 的调用完成
    // `response.json()` 调用将返回 JSON 对象或抛出一个错误
    const json = await response.json();
    console.log(json[0].name);
  }
  catch(error) {
    console.error(`无法获取产品列表：${error}`);
  }
}

fetchProducts();

```

> 记住，就像一个Promise链一样，`await`强制异步操作以串联的方式完成，如果下一个操作的结果取决于上一个操作的结果，这是必要的，但如果不是这样的，使用`Promise.all()`这样的操作会有更好的性能

## 基于Promise的API实现
### `alarm()`
- 以被唤醒人的名字和一个人被唤醒前以毫秒为单位的延迟作为参数
	- 在延迟之后，本函数将会发送一个包含就需要被唤醒人名字的"wake up!"信息
- `setTimeout()`：以一个回调函数和一个毫秒为微单的延迟作为参数
```js
const output = document.querySelector('#output');
const button = document.querySelector('#set-alarm');

function setAlarm() {
  window.setTimeout(() => {
    output.textContent = 'Wake up!';
  }, 1000);
}

button.addEventListener('click', setAlarm);

```
### `Promise()`构造器
- `Promise()`构造器使用单个函数作为参数
	- 这个函数被称作**执行器**
	- 当你创建一个新的promise使，需要实现这个执行器
- 在执行器中的两个参数：
	- `resolve`：
		- 在执行器实现里，调用的原始异步函数，如果该异步函数成功了，则调用`resolve`
	- `reject`：
		- 反之，调用`reject`
```js
function alarm(person, delay) {
  return new Promise((resolve, reject) => {
    if (delay < 0) {
      throw new Error('Alarm delay must not be negative');
    }
    window.setTimeout(() => {
      resolve(`Wake up, ${person}!`);
    }, delay);
  });
}

```
- 此函数创建并且返回一个新的 `Promise`。对于执行器中的 promise，我们：
	-   检查 `delay`（延迟）是否为负数，如果是的话就抛出一个错误。
	-   调用 `window.setTimeout()`，传递一个回调函数和 `delay`（延迟）。当计时器过期时回调会被调用，在回调函数内，我们调用了 `resolve`，并且传递了 `"Wake up!"` 消息。
### 使用`alarm()`
> `alarm()`可以返回一个`Promise`，我们可以对他做任何可以对其他`promise`做的事情
```js
const name = document.querySelector('#name');
const delay = document.querySelector('#delay');
const button = document.querySelector('#set-alarm');
const output = document.querySelector('#output');

function alarm(person, delay) {
  return new Promise((resolve, reject) => {
    if (delay < 0) {
      throw new Error('Alarm delay must not be negative');
    }
    window.setTimeout(() => {
      resolve(`Wake up, ${person}!`);
    }, delay);
  });
}

button.addEventListener('click', () => {
  alarm(name.value, delay.value)
    .then(message => output.textContent = message)
    .catch(error => output.textContent = `Couldn't set alarm: ${error}`);
});
```
- 可以对`alarm()`使用`async`和`wait`
```js
const name = document.querySelector('#name');
const delay = document.querySelector('#delay');
const button = document.querySelector('#set-alarm');
const output = document.querySelector('#output');

function alarm(person, delay) {
  return new Promise((resolve, reject) => {
    if (delay < 0) {
      throw new Error('Alarm delay must not be negative');
    }
    window.setTimeout(() => {
      resolve(`Wake up, ${person}!`);
    }, delay);
  });
}

button.addEventListener('click', async () => {
  try {
    const message = await alarm(name.value, delay.value);
    output.textContent = message;
  }
  catch (error) {
    output.textContent = `Couldn't set alarm: ${error}`;
  }
});
```

## workers简介
- Workers 和主代码运行在完全分离的环境中，只有通过相互发送消息来进行交互。特别是，这意味着 **workers 不能访问 DOM**（窗口、文档、页面元素等等）
- 三种不同类型的`workers`：
	- dedicated workers
	- shared workers
	- service workers
```js
function generatePrimes(quota) {

  function isPrime(n) {
    for (let c = 2; c <= Math.sqrt(n); ++c) {
      if (n % c === 0) {
          return false;
       }
    }
    return true;
  }

  const primes = [];
  const maximum = 1000000;

  while (primes.length < quota) {
    const candidate = Math.floor(Math.random() * (maximum + 1));
    if (isPrime(candidate)) {
      primes.push(candidate);
    }
  }

  return primes;
}

document.querySelector('#generate').addEventListener('click', () => {
  const quota = document.querySelector('#quota').value;
  const primes = generatePrimes(quota);
  document.querySelector('#output').textContent = `Finished generating ${quota} primes!`;
});

document.querySelector('#reload').addEventListener('click', () => {
  document.querySelector('#user-input').value = 'Try typing in here immediately after pressing "Generate primes"';
  document.location.reload();
});
```
- 使用`addEventListener()`来实现监听来自主脚本的消息
```js
addEventListener("message", message => {  
    if (message.data.command === 'generate') {  
        generatePrimes(message.data.quota);  
    }  
});
```