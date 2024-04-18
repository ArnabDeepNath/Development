import './App.css';
import AboutUs from './sections/AboutUs';
import HeroSection from './sections/HeroSection/';
import Navbar from './components/Navbar/Navbar';
import PortfolioSection from './sections/PortfolioSection';
import ScrollingHeader from './components/ScrollingHeader';
import Teams from './sections/Teams';

import Footer from './sections/Footer';

export default function App() {
  return (
    <div className="w-full h-full">
      <Navbar />
      <HeroSection />
      <ScrollingHeader />
      <Teams />
      <PortfolioSection />
      <AboutUs />
      <Footer />
    </div>
  );
}
