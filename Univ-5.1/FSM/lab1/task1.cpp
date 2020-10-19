#include <iostream>
#include <vector>
#include <chrono>
#include <map>
#include <algorithm>
#include <unordered_set>
#include <set>
#include <algorithm>
#include <iterator>

typedef std::tuple<int, char> tt;

class FiniteStateMachine {
public:
    FiniteStateMachine(
            int _states_count,
            std::vector<char> _alphabet,
            std::map<tt, int> _transition,
            int _start,
            std::vector<int> _final
    ) {

        for (int i = _states_count; i > 0; --i) {
            states.push_back(i - 1);
        }
        transition = std::move(_transition);
        alphabet = std::move(_alphabet);
        start_state = _start;
        std::unordered_set<int> final_states1(_final.begin(), _final.end());
        final_states = final_states1;
    }

    int start_state;
    std::unordered_set<int> final_states;

    bool contains_word(std::string word) {
        int cur_state = start_state;
        while (!word.empty()) {
            cur_state = transit(cur_state, word[0]);
            if (cur_state == -1) return false;
            word = word.substr(1);
        }
        if (final_states.count(cur_state))
            return true;
        return false;
    }

    bool contains_fsm(FiniteStateMachine fsm) {
        std::set<std::pair<int, int>> W;
        std::set<std::pair<int, int>> C;
        W.insert(std::make_pair(start_state, fsm.start_state));
        while (!W.empty()) {
            auto a_b = *W.begin();
            W.erase(W.begin());
            C.insert(a_b);
            if (final_states.count(a_b.first) && final_states.count(a_b.second))
                return false;
            for (auto const &x: alphabet) {
                int _a = transit(a_b.first, x);
                int _b = fsm.transit(a_b.second, x);
                if (_a == -1 && _b != -1) return false;
                if (_a == -1 || _b == -1) continue;
                if (C.find(std::make_pair(_a, _b)) == C.end()) W.insert(std::make_pair(_a, _b));
            }
        }
        return true;
    }


    int transit(int state, char letter) {
        if (transition.count(std::make_tuple(state, letter)))
            return transition[std::make_tuple(state, letter)];
        return -1;
    }

private:
    std::vector<int> states;
    std::vector<char> alphabet;
    std::map<tt, int> transition;

};

int main() {
    auto t1 = std::chrono::high_resolution_clock::now();
    std::vector<bool> ress;
    auto *fsm0 = new FiniteStateMachine(
            4,
            {'a', 'b', 'c'},
            {
                    {std::make_tuple(0, 'a'), 1}
            },
            0,
            {1, 2, 3}
    );

    auto *fsm1 = new FiniteStateMachine(
            4,
            {'a', 'b', 'c'},
            {
                    {std::make_tuple(0, 'a'), 1},
                    {std::make_tuple(1, 'b'), 2},
                    {std::make_tuple(2, 'a'), 2},
                    {std::make_tuple(2, 'c'), 3}
            },
            0,
            {1, 2, 3}
    );

    auto *fsm2 = new FiniteStateMachine(
            4,
            {'a', 'b', 'c', 'd'},
            {
                    {std::make_tuple(0, 'a'), 1},
                    {std::make_tuple(1, 'b'), 2},
                    {std::make_tuple(1, 'c'), 1},
                    {std::make_tuple(1, 'd'), 1},
                    {std::make_tuple(2, 'a'), 2},
                    {std::make_tuple(2, 'c'), 3}
            },
            0,
            {1, 2, 3}
    );

    auto *fsm3 = new FiniteStateMachine(
            5,
            {'a', 'b', 'c', 'd'},
            {
                    {std::make_tuple(0, 'a'), 1},
                    {std::make_tuple(1, 'b'), 2},
                    {std::make_tuple(1, 'c'), 1},
                    {std::make_tuple(1, 'd'), 1},
                    {std::make_tuple(2, 'a'), 2},
                    {std::make_tuple(2, 'c'), 3},
                    {std::make_tuple(2, 'd'), 4},
                    {std::make_tuple(3, 'a'), 0}
            },
            0,
            {1, 2, 3, 4}
    );

    // std::cout << "Check for \"abacd\"\n";
// abaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaac
    for (int i=0; i <1000000; i++ ){
        ress.push_back(fsm3->contains_word("abaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaac"));
        // ress.push_back(fsm1->contains_fsm(*fsm0));
        // auto res = fsm2->contains_fsm(*fsm0);
        // auto res = fsm1->contains_word("abc");

        // std::cout << fsm1->contains_word("abc") << '\n';
        // std::cout << fsm1->contains_fsm(*fsm0) << '\n';
    }

    // std::cout << fsm1->contains_fsm(*fsm0) << '\n';
    // std::cout << fsm3->contains_word("accdbc") << '\n';
    auto t2 = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>( t2 - t1 ).count();
    std::cout << "Executed 100000 times in " << duration << " μs\n";
    std::cout << "Average time " << duration/1000000 << " μs\n";
    std::cout << "Result: " << ress[0];
    return 0;
}
