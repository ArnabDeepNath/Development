import React from 'react';
import Nav from './components/Nav';
import Hero from './sections/Hero';
import Footer from './sections/Footer';
import PopularProducts from './sections/PopularProducts';

const App = () => {
  return (
    <main className="relative">
      <Nav />
      {/* Hero Section */}
      <Hero />
      {/* Popular Products Section */}
      <PopularProducts />
      {/* Footer */}
      <Footer />
    </main>
  );
};

export default App;
