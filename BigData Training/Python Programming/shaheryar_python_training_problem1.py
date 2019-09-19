#  Create a function which will give you a list of 'N' Gibberish words in English (Only "idig" Infix Rules and single syllable word)

'''
Rules for syllable to convert to Gibberish:-

1. When a syllable starts with more than one consonant, the infix is added after the onset consonants. Example:

creek → cridigeek, cruddageek, cruvugeek, cruthugeek
strong → stridigong, struddagong, struvugong, struthugong

2. When the syllable begins with a vowel, that vowel is used in place of the first i in the -ithieg- infix. Example:

all → idigall, uddagall, uvugall, uthugall
eat → idigeat, uddageat, uvugeat, uthugeat

# Requirements of following packages
1. pip install gibberish
2. pip install random-word

'''

# Importing Python Library for finding Gibberish words and generating random words
from gibberish import Gibberish
from random_word import RandomWords


# Function that uses Python Library to generate Gibberish Words
def getGibberishWordsUsingPyGibberish(n):
    gib = Gibberish()
    return gib.generate_words(n)


# Code Infix for generating Gibberish Word - Self
INFIX = "idig"


# Function that converts single syllable to Gibberish
def convertToGibberish(syllable):
    gibberish = ""
    syllable = syllable.lower()  # Converting to lowercase for further processing
    # Rule 2 Check
    if syllable[0] in ['a', 'e', 'i', 'o', 'u']:
        gibberish = gibberish + INFIX + syllable[0]
        return gibberish
    # Process string - Rule 1
    i = 1
    while i < len(syllable):
        # Handle vowels case
        if syllable[i] in ['a', 'e', 'i', 'o', 'u']:
            gibberish = gibberish + INFIX + syllable[i]
            # Do not impose Infix on consecutive vowels
            while i + 1 < len(syllable) and syllable[i + 1] in ['a', 'e', 'i', 'o', 'u']:
                i = i + 1
                gibberish = gibberish + syllable[i]

        else:
            gibberish = gibberish + syllable[i]

        i = i + 1

    return gibberish


# Function that find all syllables in a word
def getAllSyllables(word):
    return []


# For finding number of syllables in word
def syllable_count(word):
    word = word.lower()
    count = 0
    vowels = "aeiouy"
    if word[0] in vowels:
        count += 1
    for index in range(1, len(word)):
        if word[index] in vowels and word[index - 1] not in vowels:
            count += 1
    if word.endswith("e"):
        count -= 1
    if count == 0:
        count += 1
    return count


# Given n, Function returns n number of Gibberish Words
def getGibberishWords(n):
    gibberishWordsList = []
    r = RandomWords()
    # For n entries
    for i in range(n):
        # Generate a random word and convert to Gibberish
        try:
            word = r.get_random_word()
        except:
            i = i - 1
            continue
        print('Random Word:', word)
        # Following portion relates to word having more than one syllable
        ''''# Find all syllables in a word, then form gibberish word
        syllables = getAllSyllables(word)
        #gibberish = ""
        # Process each syllable
        #for syllable in syllables: '''
        # Only single syllable words will be processed
        if syllable_count(word) > 1:
            print('Cannot process word having multiple syllables!')
            i = i - 1
            continue
        gibberish = convertToGibberish(word)
        gibberishWordsList.append(gibberish)
    return gibberishWordsList


# Main Function

correctInput = False  # for input validation
# Input number for creating Gibberish Words of length n
num = input('How many Gibberish words you wish to see? Enter n : ')
while correctInput is False:

    try:
        num = int(num)
        while num <= 0:
            num = input('Please enter a positive number(greater than 1) : ')
            num = int(num)
        correctInput = True
    except:
        print('Invalid Number!')
        num = input('Please enter a valid number for length : ')
        correctInput = False
# Usage of Python Library and Self Made Code
option = input('Enter 1 to use Python Library and 0 for Other: ')
try:
    option = int(option)
except:
    print('Unknown Input! See Results using Python Library')
    option = 1

if option is 1:
    gibberishWords = getGibberishWordsUsingPyGibberish(
        num)  # Calling function to get all Gibberish Words using Python Library
else:
    gibberishWords = getGibberishWords(num)  # Calling function to get all Gibberish Words

print('Following is list of Gibberish Words: ', gibberishWords)
