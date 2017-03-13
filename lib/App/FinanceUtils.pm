package App::FinanceUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{calc_fv_future_value} = {
    v => 1.1,
    summary => 'Calculate future value (FV) from present value (PV), rate of return (r), and number of periods (n)',
    description => <<'_',

The formula is:

    FV = PV*(1+r)^n

But if you use simple interest (`--simple`) where the interest is not
compounded, the formula is:

    FV = PV*(1+r*n)

_
    args => {
        pv => {
            summary => 'Present value',
            schema => ['float*'],
            req => 1,
            pos => 0,
        },
        r => {
            summary => 'Rate of return, in percent',
            schema => ['float*'],
            req => 1,
            pos => 1,
        },
        n => {
            summary => 'Number of periods',
            schema => ['float*'],
            req => 1,
            pos => 2,
        },
        simple => {
            summary => 'Use simple interest (interest not compounded)',
            schema => 'bool*',
        },
    },
    examples => [
        {
            summary => 'Invest $100 at 6% annual return rate for 5 years',
            args => {pv=>100, r=>6, n=>5},
        },
        {
            summary => 'Invest $100 at 6% annual return rate for 5 years, simple interest',
            args => {pv=>100, r=>6, n=>5, simple=>1},
        },
    ],
    result_naked => 1,
};
sub calc_fv_future_value {
    my %args = @_;

    $args{simple} ? $args{pv}*(1+$args{r}/100*$args{n}) : $args{pv}*(1+$args{r}/100)**$args{n};
}

$SPEC{calc_fv_present_value} = {
    v => 1.1,
    summary => 'Calculate present value (PV) from future value (FV), rate of return (r), and number of periods (n)',
    description => <<'_',

The formula is:

    PV = FV/(1+r)^n

But if you use simple interest (`--simple`) where the interest is not
compounded, the formula is:

    PV = FV/(1+r*n)

_
    args => {
        fv => {
            summary => 'Future value',
            schema => ['float*'],
            req => 1,
            pos => 0,
        },
        r => {
            summary => 'Rate of return, in percent',
            schema => ['float*'],
            req => 1,
            pos => 1,
        },
        n => {
            summary => 'Number of periods',
            schema => ['float*'],
            req => 1,
            pos => 2,
        },
        simple => {
            summary => 'Use simple interest (interest not compounded)',
            schema => 'bool*',
        },
    },
    examples => [
        {
            summary => 'Want to get $100 after 5 years at 6% annual return rate, how much to invest?',
            args => {fv=>100, r=>6, n=>5},
        },
        {
            summary => 'Want to get $100 after 5 years at 6% annual return rate, with simple interest, how much to invest?',
            args => {fv=>100, r=>6, n=>5, simple=>1},
        },
    ],
    result_naked => 1,
};
sub calc_fv_present_value {
    my %args = @_;

    $args{simple} ? $args{fv}/(1+$args{r}/100*$args{n}) : $args{fv}/(1+$args{r}/100)**$args{n};
}

$SPEC{calc_fv_return_rate} = {
    v => 1.1,
    summary => 'Calculate return rate (r) from future value (FV), present value (PV), and number of periods (n)',
    description => <<'_',

The formula is:

    r = (FV/PV)^(1/n) - 1

_
    args => {
        fv => {
            summary => 'Future value',
            schema => ['float*'],
            req => 1,
            pos => 0,
        },
        pv => {
            summary => 'Present value',
            schema => ['float*'],
            req => 1,
            pos => 1,
        },
        n => {
            summary => 'Number of periods',
            schema => ['float*'],
            req => 1,
            pos => 2,
        },
    },
    examples => [
        {
            summary => 'Want to get $120 in 5 years using $100 investment, what is the required return rate (in percentage)?',
            args => {fv=>120, pv=>100, n=>5},
        },
    ],
    result_naked => 1,
};
sub calc_fv_return_rate {
    my %args = @_;

    (($args{fv}/$args{pv})**(1/$args{n}) - 1)*100;
}

$SPEC{calc_fv_periods} = {
    v => 1.1,
    summary => 'Calculate number of periods (n) from present value (FV), present value (PV), and return rate (r)',
    description => <<'_',

The formula is:

    n = ln(FV/PV) / ln(1+r)

_
    args => {
        fv => {
            summary => 'Future value',
            schema => ['float*'],
            req => 1,
            pos => 0,
        },
        pv => {
            summary => 'Present value',
            schema => ['float*'],
            req => 1,
            pos => 1,
        },
        r => {
            summary => 'Return rate, in percentage',
            schema => ['float*'],
            req => 1,
            pos => 2,
        },
    },
    examples => [
        {
            summary => 'Want to get $120 using $100 investment with annual 6% return rate, how many years must we wait?',
            args => {fv=>120, pv=>100, r=>6},
        },
    ],
    result_naked => 1,
};
sub calc_fv_periods {
    my %args = @_;

    log($args{fv}/$args{pv})/log(1+$args{r}/100);
}

1;
# ABSTRACT:

=head1 DESCRIPTION

This distribution contains some CLI's to do financial calculations:

# INSERT_EXECS_LIST

=cut
