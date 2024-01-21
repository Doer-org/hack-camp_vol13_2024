'use client'

import React, { useState, useEffect, ChangeEvent } from 'react';

function TextBoxComponent() {
  const [textBoxValue, setTextBoxValue] = useState('');
  const [apiResponse, setApiResponse] = useState<any>(null);

  useEffect(() => {
    const fetchFormula = async () => {
      if (!textBoxValue) return;

      try {
        const response = await fetch('https://tex-to-image2.onrender.com/projects/1/formulas/1', {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          },
          body: JSON.stringify({
            formula: {
              file_name: "test",
              content: textBoxValue
            }
          })
        });

        console.log(response);

        if (!response.ok) {
          throw new Error('Api call failed: ' + response.statusText);
        }

        const data = await response.json();
        setApiResponse(data);
      } catch (error) {
        console.error(error);
      }
    };

    fetchFormula();
  }, [textBoxValue]);

  const handleTextBoxChange = (event: ChangeEvent<HTMLInputElement>) => {
    setTextBoxValue(event.target.value);
  };

  return (
    <div>
      <input
        type="text"
        value={textBoxValue}
        onChange={handleTextBoxChange}
      />
      <p>入力された値: {textBoxValue}</p>
      {apiResponse && <p>API Response: {JSON.stringify(apiResponse)}</p>}
    </div>
  );
}

export default TextBoxComponent;
