
def search(object,key):
    global c1
    global keyfound
    if(type(object) is dict):
          for a,b in object.items():
           if(keyfound==1):
            break
           if(type(b) is dict and a==key[c1] and c1<len(key)-1):
            c1+=1
            search(b,key)
           elif a==key[c1] and c1==len(key)-1 and keyfound==0:
            print(b)
            keyfound=1
            break

try:

 print("Enter the object first")
 object=input()
 dicObject = eval(object)
 if(type(dicObject) != dict):
    print ("Please provide a valid input")
 else:
   print("Enter the key you want to search in nested object as a/b/c/d")
   key=input()
   splitstr=key.split("/")
   if(len(splitstr)<2):
    raise Exception ()
 c1=0
 keyfound=0
 search(dicObject,splitstr)

except:
  print("something went wrong Please check the inputs provided")
            

#{"a":{"b":{"c" :{"d":"e"}},"c":"hello"}}
#{"a":{"b":{"c" :{"b":"e"}},"c":"hello"}}



