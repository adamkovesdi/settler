# Ruby based group expenses splitter

Application similar to kittysplit.com and splitwise  
Quote from their website

> Jack, Jane and John go on a skiing weekend together. Jack pays for the ski-hire; Jane pays the hotel; John pays for dinner. Now who owes what?

## but how?

Create balances for everyone and feed that to my ruby script  
Inspired by this StackOverflow thread and countless personal trips
https://stackoverflow.com/questions/974922/algorithm-to-share-settle-expenses-among-a-group

## files

```
generate.rb             generates random travel balances
iterative_settler.rb    n-1 step algorithm solver
improved_settler.rb     the same as above with tolerance support (eg. < $10 difference is negligible)
np.rb                   NP complete optimum finder (very slow)
```

