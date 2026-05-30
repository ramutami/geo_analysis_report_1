program burgers
    ! 非粘性burgersを一次元風上差分と二段階lax_wendroffで。
    implicit none

    real(8), parameter :: m_pi = 4*atan(1.0d0)
    integer :: meshnum_x 
    real(8) :: nu !delta_t/delta_x
    real(8) :: epsilon !人工粘性
    integer :: numstep !dx*numstemp秒だけ時間を進める。

    real(8) :: dt,dx !meshnumx->dx->dt with respect to nu -> tfinal with respect to numstep と決まっていく。
    real(8) , allocatable :: u_upwind(:),u_lax(:),x(:)
    character(len=128) :: filename

    integer :: i,istep,ix
    real(8) :: time
     
    !======parameters==========
        meshnum_x = 200
        nu = 0.2d0
        epsilon = 0.1d0
        numstep = 200
    !==========================

    !=======初期条件(矩形波)=======
        allocate(x(meshnum_x),u_upwind(meshnum_x),u_lax(meshnum_x))
        call setup(x,u_upwind,dx)
        call setup(x,u_lax,dx)
        dt = nu*dx
    !==========================

    !====計算and出力===========
        do istep = 0 , numstep
            time = istep*dt

            !出力
            write(filename,fmt='("./dataout/burgers",i6.6,".dat")') istep
            open(10,file=filename,status='replace',action='write')
            write(10,*) "time:x:u_upwind(x):u_lax(x)"
            do ix = 1,size(x)
                write(10,*) time,x(ix),u_upwind(ix),u_lax(ix)
            end do
            close(10)

            !更新
            call push_upwind(u_upwind,dt,dx)

            
        end do
    !==========================


    stop
    contains

    subroutine setup(x, u, dx)
        implicit none
        real(8), intent(inout) :: x(:)
        real(8), intent(inout) :: u(:)
        real(8), intent(out)   :: dx

        integer :: ix, nx

        nx = size(x)

        ! 矩形波; -1 < x < 1
        dx = 2.0d0/real(nx, kind=8)

        !有限体積方的な考え方
        !nx個の格子を作る
        ! |---------o---------|--------o---------|-- ...
        ! x=-1    (ix=1)     1*dx     (ix=2)    2*dx
        ! ...--|---------o---------|--------o---------|
        !    x=1-2dx  (ix=nx-1)   x=1-dx  (ix=nx)     x=1  

        do ix = 1, nx
            x(ix) = -1.0d0 + dx*ix - dx/2.0d0 
        end do

        do ix = 1, nx
            if( x(ix) < -1.0d0/3.0d0 .or. x(ix) > +1.0d0/3.0d0 ) then
                u(ix) = 0.0d0
            else
                u(ix) = 1.0d0
            end if
        end do

    end subroutine setup

    subroutine push_upwind(u, dt, dx)
        !非粘性
        implicit none
        real(8), intent(inout) :: u(:)
        real(8), intent(in)    :: dt
        real(8), intent(in)    :: dx

        integer :: n, ix, lbx, ubx
        real(8) :: flux(size(u))

        lbx = 1
        ubx = size(u) 

        ! 数値流束 f(ix) = f_(i+1/2) = (u_i^n)^2 / 2
        do ix = lbx, ubx
            flux(ix) = (u(ix)**2.0_8 /2.0_8)
        end do

        ! 更新
        do ix = lbx+1, ubx
            u(ix) = u(ix) - dt/dx * (flux(ix) - flux(ix-1))
        end do

        ! 境界条件
        u(lbx) = u(lbx) - dt/dx * (flux(lbx) - flux(ubx))

    end subroutine push_upwind


end program burgers