#!/usr/bin/env python
# -*- coding: utf-8 -*-
# pylint: disable=C0103,C0111

from __future__ import division

# Part 1


def vectorNorm(vector):
    return sum([i ** 2 for i in vector]) ** (1 / 2)


def scalarVectorMult(vector, scalar):
    return [scalar * i for i in vector]


def sumVectors(v1, v2):
    if len(v1) != len(v2):
        return []
    return [v1[i] + v2[i] for i in range(len(v1))]


def dotProduct(v1, v2):
    if len(v1) != len(v2):
        return 0
    return sum([v1[i] * v2[i] for i in range(len(v1))])


def crossProductR3(v1, v2):
    if len(v1) != 3 or len(v2) != 3:
        return []
    return [
        (v1[1] * v2[2]) - (v2[1] * v1[2]),
        (v2[0] * v1[2]) - (v1[0] * v2[2]),
        (v1[0] * v2[1]) - (v2[0] * v1[1]),
    ]


def angleBetweenVectors(v1, v2):
    return dotProduct(v1, v2) / (vectorNorm(v1) * vectorNorm(v2))


# Part 2


def transposeMatrix(matrix):
    return [list(x) for x in zip(*matrix)]


def scalarMatrixMult(matrix, scalar):
    return [scalarVectorMult(x, scalar) for x in matrix]


def matrixAddition(m1, m2):
    if (len(m1) != len(m2)) or (len(m1[0]) != len(m2[0])):
        return []
    return [sumVectors(x, y) for x, y in zip(m1, m2)]


def matrixMult(m1, m2):
    tb = transposeMatrix(m2)
    return [[sum(ea * eb for ea, eb in zip(a, b)) for b in tb] for a in m1]


def detSarrus(m):
    if len(m) != 3 or len(m[0]) != 3:
        return 0

    posPart = (
        m[0][0] * m[1][1] * m[2][2]
        + m[0][1] * m[1][2] * m[0][2]
        + m[0][2] * m[1][0] * m[2][1]
    )
    negPart = (
        m[0][2] * m[1][1] * m[2][0]
        + m[0][0] * m[1][0] * m[2][1]
        + m[0][1] * m[1][0] * m[2][2]
    )

    return posPart - negPart
