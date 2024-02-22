import React from 'react';
import Button from '../components/Button';

const Hero = () => {
  return (
    <div className="min-h-screen flex flex-row justify-center items-center ">
      <div className="lg:h-[600px] bg-blue-50 lg:w-[1000px] h-[400px] rounded-3xl flex justify-start items-center px-16 sm:m-16 shadow-xl">
        <div className="font-bold text-wrap">
          <h1 className="text-6xl text-blue-800 py-4">
            <span>COVID-19 Risk</span>
            <br />
            <span>Assessment Tool</span>
          </h1>
          <p className="font-light py-4">
            Lorem ipsum dolor, sit amet consectetur adipisicing elit. Quas, we
            are the best in the industry with the experience of atleast 7 Years.
          </p>
          <Button />
        </div>
        <div className="px-32">Grid Image goes here</div>
      </div>
    </div>
  );
};

export default Hero;
