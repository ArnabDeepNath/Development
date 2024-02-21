import React from 'react';
import Button from '../components/Button';

const Hero = () => {
  return (
    <section>
      <div className="border-2 border-red-300 flex flex-col w-full min-h-screen max-lg:flex-row max-container justify-center px-12">
        <div className="relative w-full xl:w-2/5  flex flex-col justify-center items-start">
          <p className="font-montserrat text-lg text-coral-red ">
            Our Summer Collection
          </p>
          <h1 className="text-8xl font-palanquin ">
            <span>New Arrival</span>
            <br />
            <span className="text-coral-red font-bold font-montserrat">
              Nike
            </span>{' '}
            Shoes
          </h1>
          <p className="text-slate-500 pt-4 font-palanquin">
            Discover the greatness in the world's top sports wear company , Nike
            has been the market leader in this industry since the 90's. Nike is
            the emotion which unites players to make bold steps , in order to
            achieve greatness in any feat of human endeavour.
          </p>
          <Button label={'Shop The Best Now'} />
        </div>
      </div>
    </section>
  );
};

export default Hero;
