import datetime

class FiniteStateMachine:

    def __init__(self, states_count, alphabet, transition, start, final):
        self.states = list(range(states_count))
        self.alphabet = alphabet
        self.transition = {(i, t): v for i, t, v in transition}
        self.start_state = start
        self.final_states = final
        self.cur_state = None

    def transit(self, state, letter):
        try:
            return self.transition[(state, letter)]
        except KeyError:
            return

    def __contains__(self, item):
        if isinstance(item, str):
            return self._contains_word(item)
        if isinstance(item, type(self)):
            return self._contains_fsm(item)

    def _contains_word(self, word):
        cur_state = self.start_state
        while word:
            cur_state = self.transit(cur_state, word[0])
            if cur_state is None: return False
            word = word[1:]
        if cur_state in self.final_states: return True
        return False

    def _contains_fsm(self, fsm):
        C = []
        W = [(self.start_state, fsm.start_state)]
        while W:
            a, b = W.pop(0)
            C.append((a, b))
            if a in self.final_states and b not in fsm.final_states:
                return False
            for x in self.alphabet:
                _a = self.transit(a, x)
                _b = fsm.transit(b, x)
                if _a is None and _b is not None:
                    return False
                if _a is None or _b is None:
                    continue
                if (_a, _b) not in C:
                    W.append((_a, _b))
        return True


thelist = []

params0 = {
    'states_count': 4,
    'alphabet': ['a', 'b', 'c'],
    'transition': [
        [0, 'a', 1],
    ],
    'start': 0,
    'final': [1, 2, 3]
}
fsm0 = FiniteStateMachine(**params0)

params1 = {
    'states_count': 4,
    'alphabet': ['a', 'b', 'c'],
    'transition': [
        [0, 'a', 1],
        [1, 'b', 2],
        [2, 'a', 2],
        [2, 'c', 3]
    ],
    'start': 0,
    'final': [1, 2, 3]
}
fsm1 = FiniteStateMachine(**params1)

params2 = {
    'states_count': 4,
    'alphabet': ['a', 'b', 'c', 'd'],
    'transition': [
        [0, 'a', 1],
        [1, 'c', 1],
        [1, 'd', 1],
        [1, 'b', 2],
        [2, 'a', 2],
        [2, 'c', 3]
    ],
    'start': 0,
    'final': [1, 2, 3]
}
fsm2 = FiniteStateMachine(**params2)

params3 = {
    'states_count': 5,
    'alphabet': ['a', 'b', 'c', 'd'],
    'transition': [
        [0, 'a', 1],
        [1, 'c', 1],
        [1, 'd', 1],
        [1, 'b', 2],
        [2, 'a', 2],
        [2, 'c', 3],
        [2, 'd', 4],
        [3, 'a', 0]
    ],
    'start': 0,
    'final': [1, 2, 3, 4]
}
fsm3 = FiniteStateMachine(**params3)

# print("Check for \"abc\"")
start_time = datetime.datetime.now()

for i in range(1000000):
    # thelist.append(('abc' in fsm1, fsm0 in fsm1))  
    # thelist.append(fsm0 in fsm1)  
    thelist.append('abaaaaaaaaac' in fsm3)   

duration = (datetime.datetime.now() - start_time).total_seconds() * 1000000
print("Executed {} times in {} μs".format(1000000, duration))
print("Average time {} μs".format(duration/1000000))
print("Result: {}".format(thelist[0]))

# print('abc' in fsm1)  # return True
# print(fsm0 in fsm1)  # return True