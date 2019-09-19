def even_number(number: int) -> bool:
    """ Function which checks the number whether its even or not.
        Params:
            Param: number : A integer based number :  within any range -N to N. : int
        Return:
           Returns a Boolean Condition : [True, False], Bool

        >>> even_number(2)
        True
        >>> even_number(1)
        False
    """
    # print(type(number))
    if type(number) is int:
        return number % 2 == 0
    else:
        return "Invalid Input"

# No input
# Negative , zero , positive
# String Length ( How much length you want )
# Space Complexity % (mem * time)
# Memory %memit
# Time %timeit
# Documentation strings and testing According to the edge cases !
# Test cases should be precise
