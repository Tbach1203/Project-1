import pandas as pd
def replace_commas_in_quotes(line):
    output = []
    in_quotes = False
    for char in line:
        if char == '"':
            in_quotes = not in_quotes  # Chuyển trạng thái khi gặp dấu ngoặc
        elif char == ',' and in_quotes:
            output.append('|')  # Thay dấu ',' bằng '|' nếu đang trong ngoặc
        else:
            output.append(char)
    return ''.join(output)

# Đường dẫn file (thay đổi theo nhu cầu)
input_file = 'tmdb-movies.csv'
output_file = 'normalize-movies.csv'

with open(input_file, 'r', encoding='utf-8') as infile, \
     open(output_file, 'w', encoding='utf-8') as outfile:
    
    for line in infile:
        processed_line = replace_commas_in_quotes(line)
        outfile.write(processed_line)
        
      

# df['vote_average'] = df['vote_average'].astype(float)
# df['vote_average'] = pd.to_numeric(df['vote_average'], errors='coerce')  

# df['revenue_adj'] =df['revenue_adj'].astype(float)
# df['revenue_adj'] = pd.to_numeric(df['revenue_adj'], errors='coerce')
# df.to_csv('test.csv', index=False)

