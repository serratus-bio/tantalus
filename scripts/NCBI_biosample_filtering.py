from Bio import Entrez
# from bs4 import BeautifulSoup
import click
import gzip
from itertools import zip_longest
from multiprocessing import Pool
from tqdm import tqdm
from lxml import etree
import pandas as pd
import pickle
from collections import Counter

# Get an iterable
#https://ftp.ncbi.nlm.nih.gov/biosample/
handle = gzip.open("biosample_set.xml.gz", "r")
tree = etree.iterparse(handle, events=("end", "start"))

def preprocess(line):
    line = line.replace(' ', '_')
    line = line.replace('-', '_')
    line = line.replace(',', '')
    line = line.replace('(', '')
    line = line.replace(')', '')
    line = line.replace('/', '')
    line = line.lower()
    return line

# Parse biosamples
k = 0
final = []
for event, element in tree:
    if event == "start":
        continue
    else:
        if element.tag == "Id":
            if element.values()[0] == "BioSample":
                k+=1
                if k % 1000000 == 0:
                    print(k)
                    final = [item for sublist in final for item in sublist]
                    with open('final_' +str(k)+".pickle", 'wb') as f:
                        pickle.dump(Counter(final), f)
                    final = []
        if element.tag == "Attribute":
            values = list(set(element.values()))
            values = [preprocess(i) for i in values]
            final.append(values)
    element.clear()
    while element.getprevious() is not None:
        del(element.getparent()[0])
        
final = [item for sublist in final for item in sublist]
with open('final_' +str("end")+".pickle", 'wb') as f:
    pickle.dump(Counter(final), f)
    
x = Counter(final)
x = pd.Series(x)

#loading the counters and concatenating them
for i in range(1,17):
    with open('final_' +str(i*1000000) + '.pickle', 'rb') as f:
        data_new = pickle.load(f)
        data_new = pd.Series(data_new)
        x = x.add(data_new, fill_value=0)
        
x = x.sort_values(ascending=False)
x.to_csv("all_attributes.txt", sep="\t")
