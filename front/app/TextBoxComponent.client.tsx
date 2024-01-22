'use client';
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
        style={{ fontSize: '30px', width: '500px', padding: '10px' }} // テキストボックスのスタイル調整
      />
      {apiResponse && apiResponse.image_url && (
        <div>
          <img
            src={apiResponse.image_url}
            alt="Response Image"
            style={{ width: '100%', maxWidth: '600px' }} // 画像のスタイル調整
          />
        </div>
      )}
    </div>
  );
}

export default TextBoxComponent;
