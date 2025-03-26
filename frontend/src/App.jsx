import React, { useState } from 'react';
import axios from 'axios';

const App = () => {
  const [file, setFile] = useState(null);
  const [message, setMessage] = useState("");

  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
    console.log(e) 
  };

  const handleUpload = async () => {
    if (!file) {
      alert("Please select a file first!");
      return;
    }
    const formData = new FormData();
    formData.append('file', file);

    try {
      const response = await axios.post('http://localhost:5000/upload', formData);
      setMessage(`Conversion successful! Check: ${response.data.output_path}`);
    } catch (error) {
      setMessage("Error during upload or processing.");
    }
  };

  return (
    <div className="p-4">
      <h1 className="text-xl">Image Pixelation App</h1>
      <input type="file" onChange={handleFileChange} className="mt-4" />
      <button onClick={handleUpload} className="bg-blue-500 text-white px-4 py-2 mt-2">
        Upload & Convert
      </button>
      {message && <p className="text-green-500 mt-4">{message}</p>}
    </div>
  );
};

export default App;
