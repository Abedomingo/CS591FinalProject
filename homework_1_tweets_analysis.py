#!/usr/bin/env python
# coding: utf-8

# # Import Packages

# In[1]:


import tweepy
import yaml
import json
import sqlite3
from datetime import datetime
import pandas as pd


# # Read Twitter Authentication Keys

# In[23]:


# yaml file reader funtion
def read_yaml(file_path):
    with open(file_path, "r") as f:
        return yaml.safe_load(f)

# yaml config file path
file_path = "twitter_api_key_config.yaml"
# read from config file
api_credential = read_yaml(file_path)


# # Create Twitter Authentication

# In[24]:


# API authentication
auth = tweepy.OAuthHandler(api_credential["api_key"],                            api_credential["api_secret_token"])
auth.set_access_token(api_credential["access_token"],                       api_credential["access_token_secret"])
API = tweepy.API(auth, wait_on_rate_limit=True)


# # Create Database Connection

# In[2]:


# establish database connection
conn = sqlite3.connect('tbt_tweets.db')
# get the cursor object
cur  = conn.cursor()


# # User ID and User Name who appears most frequently in the tweets

# In[9]:


query = """ SELECT t.user_id, u.user_name, u.user_screen_name, COUNT(t.user_id) AS frequency FROM tweet_info t, user_info u WHERE t.user_id=u.user_id GROUP BY t.user_id ORDER BY COUNT(t.user_id) DESC;"""
cur.execute(query)
result = cur.fetchall()
columns = [description[0] for description in cur.description]
result_df = pd.DataFrame(result, columns=columns)
result_df


# # Retrieve again the collected tweets in order to find the most retweeted tweet

# In[84]:


query = """ SELECT tweet_id FROM tweet_info;"""
cur.execute(query)
result = cur.fetchall()
columns = [description[0] for description in cur.description]
result_df = pd.DataFrame(result, columns=columns)
tweet_ids = result_df['tweet_id'].tolist()

#Notice that the Twitter API has a rate limit of 900 requests per 15 minute window
#In order to get all the tweets updated, I ran range(0,900) and then range(900,1001) after 15 minutes. 
#For the remaining 60 tweets, I just commented both for loops and defined _id between 100100 and 100160.
#Indentation must be fixed as well for the remaining 60 tweets.

for num in range(0,900):
#for num in range(900,1001):
    id_ = tweet_ids[num*100:(num+1)*100]
    #id_ = tweet_ids[100100:100160]

    all_tweet_list = API.statuses_lookup(id_)
    for tweet in all_tweet_list:
        info = (tweet._json['retweet_count'],tweet._json['id'])
        query = """UPDATE tweet_info SET retweet_count = ? WHERE tweet_id = ?;"""
        cur.execute(query,info)
        
query = """ SELECT tweet_id, tweet_text, retweet_count FROM tweet_info ORDER BY retweet_count DESC;"""
cur.execute(query)
result = cur.fetchall()
columns = [description[0] for description in cur.description]
result_df = pd.DataFrame(result, columns=columns)
result_df


# # Add the libraries which are required in order to retrieve the most common word or hashtag besides #tbt

# In[88]:


import warnings
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import TweetTokenizer
from nltk import FreqDist
from nltk.util import ngrams
import matplotlib.pyplot as plt
import re
import string


# # Retrieve the most common word besides #tbt

# In[91]:


cur.execute("SELECT tweet_text FROM tweet_info")
all_tweet_text = cur.fetchall()
all_tweet_list=[x[0] for x in all_tweet_text]

warnings.filterwarnings("ignore")

punctuation = [x for x in string.punctuation]
stop_words = stopwords.words('english') + punctuation + ['rt', 'via',"i'm","don't"]

pat1 = r'@[A-Za-z0-9_]+'
pat2 = r'https?://[^ ]+'
combined_pat = r'|'.join((pat1, pat2))
www_pat = r'www.[^ ]+'

tokenizer = TweetTokenizer()

def tweet_tokenizer(verbatim):
    try:
        stripped = re.sub(combined_pat, '', verbatim)
        stripped = re.sub(www_pat, '', stripped)
        lower_case = stripped.lower()
        letters_only = re.sub("[^a-zA-Z]", " ", lower_case)
    
        all_tokens = tokenizer.tokenize(letters_only)
        
        # this line filters out all tokens that are entirely non-alphabetic characters
        filtered_tokens = [t for t in all_tokens if t.islower()]
        # filter out all tokens that are <2 chars
        filtered_tokens = [x for x in filtered_tokens if len(x)>1]
        
        filtered_tokens = [term for term in filtered_tokens if term not in stop_words]
        
        out_text=' '.join(filtered_tokens)
    except IndexError:
        out_text=''
        filtered_tokens = []
    return(out_text)
    

test_bed = [tweet_tokenizer(x) for x in all_tweet_list]
all_concat_str = ' '.join(test_bed)
#freq_dist_count=FreqDist(ngrams(all_concat_str.split(), 2))                  
freq_dist_count = FreqDist(all_concat_str.split())  

freq_dist_count


# In[99]:





# In[ ]:




