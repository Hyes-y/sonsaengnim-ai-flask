import numpy as np
from collections import Counter


def top_n(array, n=3):
    """
    유사도 상위 n개 데이터의 인덱스 반환 함수
    :param n:
    :param array:
    :return top_n_idx:
    """
    array = np.array(array)
    temp = np.argsort(-array)
    ranks = temp.argsort()

    top_n_idx = [0] * n
    length = len(array)
    for i in range(length):
        if ranks[i] < n:
            top_n_idx[ranks[i]] = array[i]
    return top_n_idx



def get_top_n_frequency(array, n=3):
    """
    최빈값 상위 n개 데이터 반환
    :param n:
    :param array:
    :return top_n_freq_actions:
    """
    counter = Counter(array)
    top_n_freq_actions = [i[0] for i in counter.most_common(n=n)]
    return top_n_freq_actions
