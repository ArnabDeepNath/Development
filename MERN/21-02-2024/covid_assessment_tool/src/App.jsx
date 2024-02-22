import React from 'react';
import Nav from './components/Nav';
import Hero from './sections/Hero';
import Help from './sections/Help';
import Why from './sections/Why';
import How from './sections/How';
import Footer from './sections/Footer';
const App = () => {
  return (
    <main>
      <Nav />
      {/* Hero Section */}
      <Hero />
      {/* Help Section */}
      <Help />
      {/* Why Us ? */}
      <Why />
      {/* How to  */}
      <How />
      {/* Footer */}
      <Footer />
    </main>
  );
};

export default App;
