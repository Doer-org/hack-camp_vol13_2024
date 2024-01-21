'use client'

import { METHODS } from 'http';
import React, { useState, useEffect, ChangeEvent } from 'react';
import { text } from 'stream/consumers';

function TextBoxComponent() {
  // テキストボックスの状態を管理するための state
  const [textBoxValue, setTextBoxValue] = useState('');

  const [apiResponse, setApiResponse] = useState(null);

  useEffect(() => {
    const fetchFormula = async () => {
        const response = await fetch('https://tex-to-image2.onrender.com/projects/1/formulas/1')
        METHODS  = 'Fetch',
        headers = {
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
      throw new Error('Api CALL failed: ' + response.statusText);
    }

    const data = await response.json();
    setApiResponse(data);
    };

    if (textBoxValue) {
        fetchFormula().catch(console.error);
    }
 }, [textBoxValue]);

  // テキストボックスの値が変更されたときに呼び出されるハンドラ
  const handleTextBoxChange = (event: ChangeEvent<HTMLInputElement>) => {
    // テキストボックスの値を更新
    setTextBoxValue(event.target.value);
  };

  return (
    <div>
      {/* テキストボックス */}
      <input
        type="text"
        value={textBoxValue}  // テキストボックスの値
        onChange={handleTextBoxChange}  // 値が変更されたときのハンドラ
      />

      {/* テキストボックスの値を表示 */}
      <p>入力された値: {textBoxValue}</p>

       {/* APIレスポンスの結果を表示 */}
       {apiResponse && <p>API Response: {JSON.stringify(apiResponse)}</p>}
    </div>
  );
};

export default TextBoxComponent;
