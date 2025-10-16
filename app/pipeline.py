// Simple ETL pipeline example */

import pandas as pd
import os

def extract(path):
    # Example: read Excel or CSV
    if path.endswith('.csv'):
        return pd.read_csv(path)
    elif path.endswith('.xlsx'):
        return pd.read_excel(path)
    else:
        raise ValueError('Unsupported file type')

def transform(df):
    # Example: clean column names, drop missing
    df = df.dropna()
    df.columns = [col.strip().lower().replace(' ', '_') for col in df.columns]
    return df

def load(df, out_path):
    df.to_csv(out_path, index=False)

if __name__ == "__main__":
    input_file = os.path.join('data', 'your_input_file.csv')
    output_file = os.path.join('data', 'cleaned_output.csv')
    df = extract(input_file)
    df_clean = transform(df)
    load(df_clean, output_file)
