#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#define len(x)  (sizeof(x) / sizeof((x)[0])) + 1

// Part 1

float vectorNorm(const float* vector) {
    float sum = 0;
    int i;
    int length = len(vector);
    for (i = 0; i < length; i++) {
        sum += pow(vector[i], 2);
    }
    return sqrt(sum);
}

void scalarVectorMult(float* vector, const int scalar) {
    int i;
    int length = len(vector);
    for (i = 0; i < length; i++) {
        vector[i] *= scalar;
    }
}

float* sumVectors(const float* v1, const float* v2) {
    int flen = len(v1);
    int slen = len(v2);
    float result[] = {0, 0, 0};
    if (flen != slen) {
        return result;
    }
    int i;
    for (i = 0; i < flen; i++) {
        result[i] = v1[i] + v2[i];
    }
    return result;
}

float dotProduct(const float* v1, const float* v2) {
    int flen = len(v1);
    int slen = len(v2);
    float result = 0;
    if (flen != slen) {
        return result;
    }
    int i;
    for (i = 0; i < flen; i++) {
        result += (v1[i] * v2[i]);
    }
    return result;
}

float* crossProductR3(const float* v1, const float* v2) {
    int flen = len(v1);
    int slen = len(v2);
    float result[] = {0, 0, 0};
    if (flen != 3 || slen != 3) {
        return result;
    }
    result[0] = (v1[1] * v2[2]) - (v2[1] * v1[2]);
    result[1] = (v2[0] * v1[2]) - (v1[0] * v2[2]);
    result[2] = (v1[0] * v2[1]) - (v2[0] * v1[1]);
    return result;
}

float angleBetweenVectors(const float* v1, const float* v2) {
    return dotProduct(v1, v2) / (vectorNorm(v1) * vectorNorm(v2));
}

// Part 2

void transposeMatrix(int r, int c, int m[r][c]) {
    int i, j, aux;
    for (i = 0; i < r; i++) {
        for (j = i + 1; j < c; j++) {
            if (j != i) {
                aux = m[i][j];
                m[i][j] = m[j][i];
                m[j][i] = aux;
            }
        }
    }
}

void scalarMatrixMult(int r, int c, int m[r][c], int scalar) {
    int i, j;
    for (i = 0; i < r; i++) {
        for (j = 0; j < c; j++) {
            m[i][j] *= scalar;
        }
    }
}

int** matrixAddition(int r, int c, int m1[r][c], int m2[r][c]) {
    int i, j;
    int sum[r][c];
    for (i = 0; i < r; i++) {
        for (j = 0; j < c; j++) {
            sum[i][j] = m1[i][j] + m2[i][j];
        }
    }
    return sum;
}

int** matrixMult(int r, int c, int m1[r][c], int m2[r][c]) {
    int i, j, k;
    int mul[r][c];
    for (i = 0; i < r; i++) {
        for (j = 0; j < c; j++) {
            mul[i][j] = 0;
            for (k = 0; k < c; k++) {
                mul[i][j] += (m1[i][k]*m2[k][j]);
            }
        }
    }
}

int detSarrus(int m[3][3]) {
    int posPart = m[0][0]*m[1][1]*m[2][2]+
                  m[0][1]*m[1][2]*m[0][2]+
                  m[0][2]*m[1][0]*m[2][1];

    int negPart = m[0][2]*m[1][1]*m[2][0]+
                  m[0][0]*m[1][0]*m[2][1]+
                  m[0][1]*m[1][0]*m[2][2];

    return (posPart - negPart);
}

int main() {
    return 0;
}
