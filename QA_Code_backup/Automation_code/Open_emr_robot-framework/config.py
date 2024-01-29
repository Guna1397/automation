import sys, os, json
track = 3
resource_var_key = sys.argv[3]
value = ''
index = sys.argv[1]

def get_var_value():
   resource = sys.argv[2]
   config_file_dir = "../../configurationfiles/npd/testdata/shared/configuration-files"
   config_files = os.listdir(config_file_dir)
   file_name = ''
   for file in config_files:
      if resource in file:
         file_name = file
      if file_name:
         break
   if not file_name:
      print(f'file with resource {resource} not found')
      return None
   with open(os.path.join(config_file_dir, file_name), 'rb') as file:
      file_content = json.load(file)
      parse_json(file_content)
      return value


def parse_json(file_content):
   global track
   global value
   global index
   for k, v in file_content.items():
      if sys.argv[track].lower() in k:
         if type(v) == dict:
            track = track + 1
            parse_json(v)
         elif type(v) == list:
            value = v[int(index)]
            return
         else:
            value = v
            return

if __name__ == "__main__":
    print(get_var_value())