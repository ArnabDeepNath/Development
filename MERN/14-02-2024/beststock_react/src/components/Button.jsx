import React from 'react';

const Button = ({ label }) => {
  return (
    <button className="flex bg-coral-red justify-center text-white px-10 py-4 mt-16 text-lg rounded-xl">
      {label}
    </button>
  );
};

export default Button;
