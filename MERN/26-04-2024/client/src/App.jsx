import './App.css';
import React, { useState } from 'react';
import Axios from 'axios';
function App() {
  const [username, setUsername] = useState('');

  const [name, setName] = useState('');
  const [email, setEmail] = useState('');

  const addUser = () => {
    Axios.post('http://localhost:8000/add-user', { name, email });
    setName('');
    setEmail('');
  };
  return (
    <>
      <div className="flex flex-col justify-evenly items-start p-8 w-[25rem] h-full bg-gray-200 rounded-xl ring-1 m-8">
        <h1>Name</h1>
        <input
          className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-[20rem] p-2.5 mb-8"
          type="text"
          onChange={(e) => {
            setName(e.target.value);
          }}
        />
        <h1>Email</h1>
        <input
          className="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-[20rem] p-2.5 mb-8"
          type="text"
          onChange={(e) => {
            setEmail(e.target.value);
          }}
        />
        <button
          className="w-[20rem] text-lg bg-blue-400 text-green rounded-xl ring-2 "
          onClick={addUser}>
          Add User
        </button>
      </div>
    </>
  );
}

export default App;
