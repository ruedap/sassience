import React from 'react';
import logo from './logo.png';
import './App.css';

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>This site is temporarily unavailable.</p>
        <a
          className="App-link"
          href="https://github.com/ruedap/sassience"
          target="_blank"
          rel="noopener noreferrer"
        >
          ruedap/sassience
        </a>
      </header>
    </div>
  );
}

export default App;
