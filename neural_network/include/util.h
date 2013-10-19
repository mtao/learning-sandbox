#ifndef UTIL_H
#define UTIL_H

namespace internal {
    template <typename ContainerType>
    struct offset_pair {
        typedef typename ContainerType::iterator iterator_type;
        offset_pair(ContainerType& cont) {
            front = cont.begin();
            back = front++;
        }
        iterator_type operator()() {
            return front;
        }
        iterator_type& operator++() {
            ++front;
            ++back;
            return front;
        }
        iterator_type front;
        iterator_type back;
    };
    template <typename ContainerType>
    struct offset_pair_const {
        typedef typename ContainerType::const_iterator iterator_type;
        offset_pair_const(const ContainerType& cont) {
            front = cont.cbegin();
            back = front++;
        }
        iterator_type operator()() const {
            return front;
        }
        iterator_type& operator++() {
            ++front;
            ++back;
            return front;
        }
        iterator_type front;
        iterator_type back;
    };
    template <typename ContainerType>
    struct offset_pair_const_reverse {
        typedef typename ContainerType::const_reverse_iterator iterator_type;
        offset_pair_const_reverse(const ContainerType& cont) {
            front = cont.crbegin();
            back = front++;
        }
        iterator_type operator()() const {
            return front;
        }
        iterator_type& operator++() {
            ++front;
            ++back;
            return front;
        }
        iterator_type front;
        iterator_type back;
    };
}
#endif
