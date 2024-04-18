import React from 'react';
import ConnectNowBtn from '../components/ConnectNowBtn/ConnectNowBtn';

const HeroSection = () => {
  return (
    <div className="w-full h-screen bg-white p-1">
      <div className="textstructure mt-40 text-start px-12">
        <div className="masker">
          <h1 className="uppercase text-9xl tracking-tighter font-bold leading-[12vw] xl:leading-[5.5vw] ">
            Designs
          </h1>
          <h1 className="uppercase text-9xl tracking-tighter font-bold leading-[12vw] xl:leading-[5.5vw] ">
            Flow
          </h1>
          <h1 className="uppercase text-9xl tracking-tighter font-bold leading-[12vw] xl:leading-[5.5vw] ">
            Art
          </h1>
        </div>
        <div className="w-full h-32 flex justify-between space-x-16 mt-8 p-4">
          <div className="w-full h-[1px] bg-zinc-400"></div> {/* Divider */}
          <ConnectNowBtn />
        </div>
      </div>
    </div>
  );
};

export default HeroSection;
