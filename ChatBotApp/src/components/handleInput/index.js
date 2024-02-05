import React, { useState, useEffect } from 'react';
import "./index.css"
const SearchAll = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const [searchResults, setSearchResults] = useState([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        // Replace 'your-api-endpoint' with the actual API endpoint you want to query
        const response = await fetch(`https://v2.jokeapi.dev/joke/Any?type=single&amount=10?query=${searchTerm}`);
        const data = await response.json();
        setSearchResults(data);
      } catch (error) {
        console.error('Error fetching data:', error);
      } finally {
        setLoading(false);
      }
    };

    if (searchTerm.trim() !== '') {
      fetchData();
    } else {
      // Clear search results if the search term is empty
      setSearchResults([]);
    }
  }, [searchTerm]);

  const handleInputChange = (event) => {
    setSearchTerm(event.target.value);
  };

  return (
    <div className='search_container'>
      <input
        className='search_input'
        type="text"
        placeholder="SEARCH ME"
        value={searchTerm}
        onChange={handleInputChange}
      />
    
      {loading && <p>Loading...</p>}
    
      {searchResults.length > 0 && (
        <ul className='search_results'>
          {searchResults.map((result) => (
            <li className='search_result' key={result.id}>{result.name}</li>
          ))}
        </ul>
      )}
    
      {searchResults.length === 0 && !loading && (
        <p className='no_results'>No results found. Try reducing to a few key words.</p>
      )}
    </div>
  );
};

export default SearchAll;
