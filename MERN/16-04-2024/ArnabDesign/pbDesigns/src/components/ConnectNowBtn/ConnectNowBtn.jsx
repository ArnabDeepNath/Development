import React from 'react';
import './ConnectNowBtn.css';

const ConnectNowBtn = () => {
  return (
    <div className="explore w-[200px] h-12 flex items-center justify-between text-zinc-400 text-lg border-solid border-2 border-zinc-400 rounded-3xl px-6 py-2 hover:bg-zinc-800 hover:text-white hover:cursor-pointer transition-colors duration-300 uppercase">
      <h1>Explore</h1>
      <img
        className="arrow-icon -rotate-[45deg] p-14"
        src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAYAAABw4pVUAAAACXBIWXMAAAsTAAALEwEAmpwYAAACU0lEQVR4nO3cu49NURiG8Wdc4hIJhaBQCCFxDToqnWpKnZKKWkFJoXKJf4BKiQmZDBIJUWiIQiEahUgkrsG4G9nJ0cg48x2T2d8e3/NLVjvz5rxn73PO2mstkCRJkiRJkiRJkiRJkiRJAub4KuTbDowBn4AvwFVgY3aoqrYBH4CJP8YbYGd2uIpGJynj93gBbMgOWM3nPoU04ymwOjtkJeNTFNKMR8Dy7KBVXAoU0ox7wJLssBWsA94FS7kJLMgOXMEu4GOwlMvAvOzAFQwD34KlXACGsgNXsB/4ESzlbHbYKg4FC2nGkeywVRwPFvITOJgdtorTwVK+A/uyw1aZ9b0YLKWZkNybHbiC+cC1YCnN1+bd2YErWATcDpbyEtiUHbiCpcD9YCnPgDXZgStYATwOlvIEWJUduIK1wPNgKQ+BZdmBK9gCvAqWchdYHPmjm4GRAWY5Hfzza3BlqsnIrcB7X2TafJOd7zcZed0yyLjiT01Wxlzgq4WQdQs+ZiF06vPv6GRXyVgHgk0UHOf8UGd2fKjTm29pvo697UDYiepfe9XeD8NbwMJp/j/14dTJLJ5cXJkd+H+ffn8QLMPp9xYeUN0JluEDqhnmI9wOcZFDx5wJ3qZcBtSCEwMslDvQRqDKDg/wK9ylpB1abH1ypsNUNzzAdoQpJws1PXt6e9QjZbhhZ4atd0tbt4wErww3fbZgKHirclt0S5pFHx4c0DH9lkV5tEaCHX/ZEv3aw2dyj2e60fsdMt57Du6hMx3hAWaSJEmSJEmSJEmSJEmSJDFNvwCvTnVUJTFBwQAAAABJRU5ErkJggg=="
        alt="Arrow"></img>
    </div>
  );
};

export default ConnectNowBtn;
