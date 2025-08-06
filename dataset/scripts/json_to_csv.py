import json
import pandas as pd
import os

def convert_json_to_csv_chunked(json_path, csv_path, chunksize=10000):
    """
    Convert large JSON file to CSV by processing in chunks
    """
    first_chunk = True
    total_rows = 0
    with open(json_path, 'r', encoding='utf-8') as file:
        chunk = []
        line_num = 0
        for line in file:
            line_num += 1
            try:
                record = json.loads(line)
                chunk.append(record)
                
                # Process chunk when it reaches the specified size
                if len(chunk) >= chunksize:
                    df = pd.DataFrame(chunk)
                    
                    # Write to CSV (append mode after first chunk)
                    mode = 'w' if first_chunk else 'a'
                    header = first_chunk
                    df.to_csv(csv_path, mode=mode, header=header, index=False, sep=';')
                    
                    total_rows += len(df)
                    print(f"Processed {total_rows:,} rows...", end='\r')
                    
                    # Clean up
                    first_chunk = False
                    chunk = []
                    
            except json.JSONDecodeError as e:
                print(f"Error parsing line {line_num}: {e}")
                raise e
        
        # Process remaining records
        if chunk:
            df = pd.DataFrame(chunk)
            mode = 'w' if first_chunk else 'a'
            header = first_chunk
            df.to_csv(csv_path, mode=mode, header=header, index=False)
            total_rows += len(df)
    
    print(f"Total rows converted: {total_rows:,}")
    return total_rows


folder_path = 'dataset/yelp'
for file_name in os.listdir(folder_path):
    file_path = os.path.join(folder_path, file_name)
    if '.json' in file_name:
        csv_file_name = file_name.replace('.json', '.csv')
        csv_file_path = os.path.join(folder_path, csv_file_name)
        
        convert_json_to_csv_chunked(file_path, csv_file_path, 20000)
        print(f"Finish converting {file_name} to CSV.")
